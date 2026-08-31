/// Normalized error surfaced to the UI layer for every failed request, so
/// screens can render a single, consistent error state.
class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.fieldErrors = const {},
  });

  final String message;
  final int? statusCode;

  /// Laravel validation errors keyed by field name, e.g. `{"phone": ["..."]}`
  final Map<String, List<String>> fieldErrors;

  bool get isUnauthorized => statusCode == 401;
  bool get isValidationError => statusCode == 422;
  bool get isNetworkError => statusCode == null;

  String? errorFor(String field) {
    final errors = fieldErrors[field];
    return errors == null || errors.isEmpty ? null : errors.first;
  }

  @override
  String toString() => message;
}
