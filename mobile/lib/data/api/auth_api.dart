import 'package:dio/dio.dart';

import '../../core/errors/app_error.dart';
import 'api_client.dart';

final class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.tenantId,
    this.userId,
  });

  final String accessToken;
  final String refreshToken;
  final String? tenantId;
  final String? userId;
}

final class AuthApi {
  const AuthApi(this._client);

  final ApiClient _client;

  Future<AuthTokens> login({
    required String email,
    required String password,
    String? tenantSlug,
    String? tenantId,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw ArgumentError('E-Mail und Passwort sind erforderlich.');
    }

    if (_client.dio.options.baseUrl.contains('example.invalid')) {
      return const AuthTokens(
        accessToken: 'demo-access-token',
        refreshToken: 'demo-refresh-token',
      );
    }

    try {
      final response = await _client.dio.post<Map<String, Object?>>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
          if (tenantSlug != null && tenantSlug.trim().isNotEmpty)
            'tenantSlug': tenantSlug.trim(),
          if (tenantId != null && tenantId.trim().isNotEmpty)
            'tenantId': tenantId.trim(),
        },
      );
      return _parseTokens(response.data ?? const {});
    } on DioException catch (error, stackTrace) {
      throw AuthError(
        message: 'Login failed.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    if (refreshToken.trim().isEmpty) {
      throw const AuthError(message: 'No refresh token available.');
    }

    try {
      final response = await _client.dio.post<Map<String, Object?>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      return _parseTokens(
        response.data ?? const {},
        fallbackRefreshToken: refreshToken,
      );
    } on DioException catch (error, stackTrace) {
      throw AuthError(
        message: 'Session refresh failed.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  AuthTokens _parseTokens(
    Map<String, Object?> data, {
    String? fallbackRefreshToken,
  }) {
    final nestedTokens = data['tokens'];
    final tokenData = nestedTokens is Map
        ? Map<String, Object?>.from(nestedTokens)
        : data;
    final accessToken = tokenData['accessToken']?.toString() ?? '';
    final refreshToken =
        tokenData['refreshToken']?.toString() ?? fallbackRefreshToken ?? '';
    final rawUser = data['user'];
    final user = rawUser is Map ? Map<String, Object?>.from(rawUser) : null;

    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw const AuthError(
        message: 'Authentication response did not include valid tokens.',
      );
    }

    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tenantId: user?['tenantId']?.toString(),
      userId: user?['id']?.toString(),
    );
  }
}
