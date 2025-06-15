
import '../../lynk_io.dart';

class ApiResponse<T> {
  final T? data;
  final ApiError? error;
  final bool isSuccess;

  ApiResponse.success(this.data)
      : error = null,
        isSuccess = true;

  ApiResponse.failure(this.error)
      : data = null,
        isSuccess = false;
}

