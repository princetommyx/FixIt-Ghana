import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/auth_repository.dart';
import '../../data/models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiClientProvider), ref.watch(tokenStorageProvider));
});

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(AuthController.new);

/// Auth state as `AsyncValue<User?>`: loading while restoring/checking a
/// session, data(null) when signed out, data(user) when signed in, error on
/// a failed sign-in/sign-up attempt.
class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final storage = ref.watch(tokenStorageProvider);
    final token = await storage.read();
    if (token == null) return null;

    try {
      return await ref.read(authRepositoryProvider).me();
    } on ApiException {
      await storage.clear();
      return null;
    }
  }

  Future<void> register({
    required String role,
    required String name,
    required String password,
    String? phone,
    String? email,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(authRepositoryProvider).register(
            role: role,
            name: name,
            password: password,
            phone: phone,
            email: email,
          );
      return result.user;
    });
  }

  Future<void> login({required String identifier, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(authRepositoryProvider)
          .login(identifier: identifier, password: password);
      return result.user;
    });
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }

  /// Called by the API client interceptor when a request comes back 401 —
  /// the token is already gone server-side, so just clear local state.
  void forceLogout() {
    state = const AsyncData(null);
  }
}
