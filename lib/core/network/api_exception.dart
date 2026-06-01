import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, {this.code});

  @override
  String toString() => 'ApiException(code: $code, message: $message)';

  static ApiException fromDio(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return ApiException('Connection timeout');
    }

    if (err.type == DioExceptionType.cancel) {
      return ApiException('Request cancelled');
    }

    if (err.response != null) {
      final code = err.response?.statusCode;
      final data = err.response?.data;
      String message;

      if (data == null) {
        message =
            err.response?.statusMessage ??
            err.error?.toString() ??
            'Unknown error';
      } else if (data is String) {
        message = data;
      } else if (data is Map) {
        message = (data['message'] ?? data['error'] ?? data.toString())
            .toString();
      } else {
        message = data.toString();
      }

      return ApiException(message, code: code);
    }

    final fallback = err.error?.toString() ?? 'Unexpected error';
    return ApiException(fallback);
  }
}
