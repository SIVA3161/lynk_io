
import '../../lynk_io.dart';

import 'api_error.dart';

/// A generic class representing the result of an API operation.
///
/// [ApiResponse] wraps both the success and failure outcomes of a request,
/// allowing for a unified way to handle responses throughout your app.
class ApiResponse<T> {
  /// The actual data returned by the API when the request is successful.
  final T? data;

  /// The error object returned when the request fails.
  final ApiError? error;

  /// Indicates whether the API call was successful.
  final bool isSuccess;

  /// Creates a successful [ApiResponse] containing the [data].
  ///
  /// The [error] is set to `null` and [isSuccess] is `true`.
  ApiResponse.success(this.data)
      : error = null,
        isSuccess = true;

  /// Creates a failed [ApiResponse] containing the [error].
  ///
  /// The [data] is set to `null` and [isSuccess] is `false`.
  ApiResponse.failure(this.error)
      : data = null,
        isSuccess = false;
}

