
import 'package:dio/dio.dart';

class DioFactory {
  static Dio create({
    required String baseUrl,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    final dio = Dio(options);

    // Optional interceptors
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }
}
