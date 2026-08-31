/// Runtime configuration. Override at build time with:
/// `flutter run --dart-define=API_BASE_URL=https://api.fixitghana.com/api/v1`
abstract final class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000/api/v1',
  );
}
