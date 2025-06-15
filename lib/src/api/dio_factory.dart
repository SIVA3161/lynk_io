
import 'package:dio/dio.dart';


/// A factory class responsible for creating configured [Dio] instances.
///
/// [DioFactory] centralizes Dio initialization with base options and optional interceptors,
/// allowing consistent API client setup throughout the app or SDK.
class DioFactory {
  /// Creates and returns a new [Dio] instance with provided [baseUrl], optional [headers],
  /// and optional [interceptors].
  ///
  /// The created Dio client is configured with:
  /// - `connectTimeout`: 10 seconds
  /// - `receiveTimeout`: 10 seconds
  ///
  /// Example:
  /// ```dart
  /// final dio = DioFactory.create(
  ///   baseUrl: 'https://api.example.com',
  ///   headers: {'Authorization': 'Bearer your_token'},
  ///   interceptors: [YourCustomInterceptor()],
  /// );
  /// ```
  ///
  /// - [baseUrl]: The base URL for all API requests.
  /// - [headers]: Optional headers to be included in every request.
  /// - [interceptors]: Optional list of Dio interceptors like logging, auth tokens, etc.
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
