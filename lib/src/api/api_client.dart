
import 'package:dio/dio.dart';

import '../../lynk_io.dart';

class ApiClient {
  final Dio _dio;
  late final FileUtils files;

  ApiClient._(this._dio) {
    files = FileUtils(_dio);
  }

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

  /// GET
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get(endpoint, queryParameters: query, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// POST
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.post(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// PUT
  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.put(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// PATCH
  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.patch(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }

  /// DELETE
  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.delete(endpoint, data: data, cancelToken: cancelToken);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(ApiError.fromDioError(e));
    }
  }
}


