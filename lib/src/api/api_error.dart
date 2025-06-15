import 'package:dio/dio.dart';

/// Represents an error that occurred during an API call.
///
/// This class is used to capture and expose relevant information from
/// a Dio exception, such as the error message and HTTP status code.
class ApiError {
  final String message;
  final int? code;

  /// Creates an [ApiError] with the given [message] and optional [code].
  ApiError({required this.message, this.code});

  /// Factory constructor that creates an [ApiError] from a [DioException].
  ///
  /// This is useful when catching errors from Dio and translating them
  /// into a standardized error model for the app.
  factory ApiError.fromDioError(DioException e) {
    return ApiError(
      message: e.message ?? "Unknown Error",
      code: e.response?.statusCode,
    );
  }
}