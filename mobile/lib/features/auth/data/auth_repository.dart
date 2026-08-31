import '../../../core/network/api_client.dart';
import '../../../core/network/token_storage.dart';
import 'models/user.dart';

class AuthResult {
  const AuthResult(this.user, this.token);

  final User user;
  final String token;
}

class AuthRepository {
  AuthRepository(this._client, this._tokenStorage);

  final ApiClient _client;
  final TokenStorage _tokenStorage;

  Future<AuthResult> register({
    required String role,
    required String name,
    required String password,
    String? phone,
    String? email,
  }) async {
    final response = await _client.post('/auth/register', data: {
      'role': role,
      'name': name,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (email != null && email.isNotEmpty) 'email': email,
      'password': password,
      'password_confirmation': password,
    });

    return _persist(response.data as Map<String, dynamic>);
  }

  Future<AuthResult> login({required String identifier, required String password}) async {
    final response = await _client.post('/auth/login', data: {
      'identifier': identifier,
      'password': password,
      'device_name': 'mobile',
    });

    return _persist(response.data as Map<String, dynamic>);
  }

  Future<User> me() async {
    final response = await _client.get('/auth/me');
    return User.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<void> logout() async {
    try {
      await _client.post('/auth/logout');
    } finally {
      await _tokenStorage.clear();
    }
  }

  Future<AuthResult> _persist(Map<String, dynamic> body) async {
    final token = body['token'] as String;
    final user = User.fromJson(body['user'] as Map<String, dynamic>);
    await _tokenStorage.save(token);
    return AuthResult(user, token);
  }
}
