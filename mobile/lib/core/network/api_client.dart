import 'package:dio/dio.dart';
import '../config/env.dart';
import 'api_exception.dart';
import 'token_storage.dart';

/// Thin wrapper around Dio: attaches the bearer token to every request,
/// normalizes failures into [ApiException], and exposes a single instance
/// screens/repositories talk to instead of touching Dio directly.
class ApiClient {
  ApiClient({TokenStorage? tokenStorage, void Function()? onUnauthorized})
      : _tokenStorage = tokenStorage ?? TokenStorage(),
        _onUnauthorized = onUnauthorized,
        _dio = Dio(
          BaseOptions(
            baseUrl: Env.apiBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {'Accept': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.read();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final void Function()? _onUnauthorized;

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? query}) =>
      _run(() => _dio.get(path, queryParameters: query));

  Future<Response<dynamic>> post(String path, {Object? data}) =>
      _run(() => _dio.post(path, data: data));

  Future<Response<dynamic>> patch(String path, {Object? data}) =>
      _run(() => _dio.patch(path, data: data));

  Future<Response<dynamic>> delete(String path) => _run(() => _dio.delete(path));

  Future<Response<dynamic>> _run(Future<Response<dynamic>> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _toApiException(error);
    }
  }

  ApiException _toApiException(DioException error) {
    final response = error.response;
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'] as String? ?? 'Something went wrong. Please try again.';
      final rawErrors = data['errors'];
      final fieldErrors = <String, List<String>>{};

      if (rawErrors is Map) {
        for (final entry in rawErrors.entries) {
          final value = entry.value;
          fieldErrors[entry.key.toString()] =
              value is List ? value.map((e) => e.toString()).toList() : [value.toString()];
        }
      }

      return ApiException(
        message: message,
        statusCode: response?.statusCode,
        fieldErrors: fieldErrors,
      );
    }

    final isNetworkFailure = error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout;

    return ApiException(
      message: isNetworkFailure
          ? 'Cannot reach FixIt Ghana. Check your connection and try again.'
          : 'Something went wrong. Please try again.',
      statusCode: response?.statusCode,
    );
  }
}
