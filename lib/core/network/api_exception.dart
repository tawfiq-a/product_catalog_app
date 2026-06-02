import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, {this.code});

  @override
  String toString() => 'ApiException(code: $code, message: $message)';

  static ApiException fromDio(DioException err) {
    final errorStr = err.error?.toString().toLowerCase() ?? '';
    final messageStr = err.message?.toLowerCase() ?? '';

    final isConnectionError = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        errorStr.contains('socketexception') ||
        errorStr.contains('failed host lookup') ||
        errorStr.contains('network') ||
        errorStr.contains('connection') ||
        messageStr.contains('socketexception') ||
        messageStr.contains('failed host lookup') ||
        messageStr.contains('network') ||
        messageStr.contains('connection');

    if (isConnectionError) {
      return ApiException('No internet connection');
    }

    if (err.type == DioExceptionType.cancel) {
      return ApiException('Request cancelled');
    }

    return ApiException('Something went wrong');
  }
}
