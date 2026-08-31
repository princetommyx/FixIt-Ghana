import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure on-device storage for the Sanctum bearer token. Never persisted in
/// plain SharedPreferences — the spec requires secure token storage.
class TokenStorage {
  TokenStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'fixit.auth_token';

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: _tokenKey);

  Future<void> save(String token) => _storage.write(key: _tokenKey, value: token);

  Future<void> clear() => _storage.delete(key: _tokenKey);
}
