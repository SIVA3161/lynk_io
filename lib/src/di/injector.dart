
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../lynk_io.dart';
import '../api/interceptors/logger_interceptors.dart';

final locator = GetIt.instance;

void setupDependencies({
  required String baseUrl,
  Future<String?> Function()? getToken,
}) {
  final interceptors = <Interceptor>[];

  if (getToken != null) {
    interceptors.add(authInterceptor(getToken: getToken));
  }

  locator.registerLazySingleton(() => ApiClient(
    baseUrl: baseUrl,
    interceptors: interceptors,
  ));
}
