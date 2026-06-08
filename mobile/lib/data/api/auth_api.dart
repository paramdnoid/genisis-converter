import 'api_client.dart';

final class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

final class AuthApi {
  const AuthApi(this._client);

  final ApiClient _client;

  Future<AuthTokens> login({
    required String email,
    required String password,
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

    final response = await _client.dio.post<Map<String, Object?>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = response.data ?? const {};
    return AuthTokens(
      accessToken: data['accessToken']?.toString() ?? '',
      refreshToken: data['refreshToken']?.toString() ?? '',
    );
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    final response = await _client.dio.post<Map<String, Object?>>(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    final data = response.data ?? const {};
    return AuthTokens(
      accessToken: data['accessToken']?.toString() ?? '',
      refreshToken: data['refreshToken']?.toString() ?? refreshToken,
    );
  }
}
