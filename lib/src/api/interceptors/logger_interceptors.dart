
import 'package:dio/dio.dart';
import 'package:lynk_io/lynk_io.dart';


/// A custom [Interceptor] that logs HTTP request, response, and error events.
///
/// Useful for debugging network interactions by printing readable logs
/// for requests and responses.
///
/// Example:
/// ```dart
/// dio.interceptors.add(LoggerInterceptor());
/// ```
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('➡️ ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info('✅ ${response.statusCode} ${response.requestOptions.uri}');
    AppLogger.info('response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error('⛔ ERROR: ${err.message}');
    super.onError(err, handler);
  }
}


/// Returns an [Interceptor] that injects a Bearer token into the `Authorization` header
/// for every outgoing HTTP request.
///
/// This is useful for authenticated APIs that require a token-based header.
///
/// Example:
/// ```dart
/// dio.interceptors.add(
///   authInterceptor(getToken: () async => 'your_token_here'),
/// );
/// ```
///
/// - [getToken]: A function that returns a `Future<String?>` token value to be added as a Bearer token.
Interceptor authInterceptor({required Future<String?> Function() getToken}) {
  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
  );
}

