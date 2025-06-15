import 'package:dio/dio.dart';
import '../../lynk_io.dart';

/// A lightweight API client built over Dio to simplify
/// HTTP requests and error handling.
///
/// Use this client to perform `GET`, `POST`, `PUT`, `PATCH`, and `DELETE`
/// operations with automatic response mapping and error formatting.
class ApiClient {
  final Dio _dio;
  late final FileUtils files;

  ApiClient._(this._dio) {
    files = FileUtils(_dio);
  }

  /// Factory constructor to initialize Dio with optional headers and interceptors.
  ///
  /// [baseUrl] - Base URL of your API (e.g., `https://api.example.com`)
  /// [headers] - Optional default headers for all requests.
  /// [interceptors] - Optional Dio interceptors for request/response transformation.
  factory ApiClient({
    required String baseUrl,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    final dio = DioFactory.create(
      baseUrl: baseUrl,
      headers: headers,
      interceptors: interceptors,
    );
    return ApiClient._(dio);
  }

  /// Sends a GET request.
  ///
  /// [endpoint] - The API endpoint (e.g., `/users`).
  /// [fromJson] - A function that converts JSON to your model.
  /// [query] - Optional query parameters.
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get(endpoint,
          queryParameters: query, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// Sends a POST request with JSON or form data.
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res =
      await _dio.post(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// Sends a PUT request.
  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res =
      await _dio.put(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// Sends a PATCH request.
  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res =
      await _dio.patch(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// Sends a DELETE request.
  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    try {
      final res =
      await _dio.delete(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }
}