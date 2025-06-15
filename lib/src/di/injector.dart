
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../lynk_io.dart';
import '../api/interceptors/logger_interceptors.dart';

/// Global service locator instance used for dependency injection.
final locator = GetIt.instance;

/// Configures and registers dependencies used across the app.
///
/// - Registers an `ApiClient` with the given [baseUrl] and optional [getToken] function.
/// - Automatically adds the `authInterceptor` if a token getter is provided.
///
/// Example:
/// ```dart
/// setupDependencies(
///   baseUrl: "https://api.example.com",
///   getToken: () async => "token_here",
/// );
/// final api = locator<ApiClient>();
/// ```
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
