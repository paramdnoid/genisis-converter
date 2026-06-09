import 'package:dio/dio.dart';

import '../../core/config/app_environment.dart';
import '../../core/errors/app_error.dart';

final class ApiClient {
  ApiClient({
    required AppEnvironment environment,
    Dio? dio,
    String? Function()? accessTokenProvider,
  }) : _dio =
           dio ?? Dio(BaseOptions(baseUrl: environment.apiBaseUrl.toString())) {
    _enforceHttps(environment);
    if (accessTokenProvider != null) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final accessToken = accessTokenProvider();
            if (accessToken != null && accessToken.trim().isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
            handler.next(options);
          },
        ),
      );
    }
  }

  final Dio _dio;

  Dio get dio => _dio;

  void _enforceHttps(AppEnvironment environment) {
    final uri = environment.apiBaseUrl;

    final isLocal =
        uri.host == 'localhost' || uri.host == '127.0.0.1' || uri.host == '::1';
    if (!environment.isDevelopment && uri.scheme != 'https' && !isLocal) {
      throw const NetworkError(message: 'API base URL must use HTTPS.');
    }
  }
}
