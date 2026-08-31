import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';
import '../network/token_storage.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    tokenStorage: ref.watch(tokenStorageProvider),
    onUnauthorized: () => ref.read(authControllerProvider.notifier).forceLogout(),
  );
});
