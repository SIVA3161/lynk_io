
import 'package:dio/dio.dart';

class ApiError {
  final String message;
  final int? code;

  ApiError({required this.message, this.code});

  factory ApiError.fromDioError(DioException e) {
    return ApiError(
      message: e.message ?? "Unknown Error",
      code: e.response?.statusCode,
    );
  }
}