
import 'package:dio/dio.dart';
import 'package:lynk_io/lynk_io.dart';

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

