import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';
import 'package:kaminfeger_mobile/data/api/api_client.dart';
import 'package:kaminfeger_mobile/data/api/auth_api.dart';
import 'package:kaminfeger_mobile/data/repositories/secure_auth_repository.dart';

import '../../helpers/fake_http_client_adapter.dart';

void main() {
  group('SecureAuthRepository', () {
    test('does not persist credentials when login is rejected', () async {
      final storage = <String, String>{};
      FlutterSecureStorage.setMockInitialValues(storage);
      final repository = SecureAuthRepository(
        api: _authApiWithStatus(401, '{"message":"invalid credentials"}'),
      );

      await expectLater(
        repository.login(email: 'tech@example.ch', password: 'wrong-password'),
        throwsA(
          isA<AuthError>().having(
            (error) => error.message,
            'message',
            'Login failed.',
          ),
        ),
      );

      expect(storage, isEmpty);
      expect(await repository.restore(), isNull);
    });

    test('successful login stores the online session tokens', () async {
      final storage = <String, String>{};
      FlutterSecureStorage.setMockInitialValues(storage);
      final adapter = FakeHttpClientAdapter(
        (options) => ResponseBody.fromString(
          '{"accessToken":"online-access","refreshToken":"online-refresh"}',
          200,
          headers: jsonHeaders,
        ),
      );
      final repository = SecureAuthRepository(api: _authApi(adapter));

      final session = await repository.login(
        email: 'tech@example.ch',
        password: 'correct-password',
      );

      expect(adapter.requests.single.path, '/auth/login');
      expect(session.email, 'tech@example.ch');
      expect(session.accessToken, 'online-access');
      expect(session.refreshToken, 'online-refresh');
      expect(storage['auth.email'], 'tech@example.ch');
      expect(storage['auth.accessToken'], 'online-access');
      expect(storage['auth.refreshToken'], 'online-refresh');
      expect(await repository.restore(), isNotNull);
    });

    test('successful login accepts backend nested token responses', () async {
      final storage = <String, String>{};
      FlutterSecureStorage.setMockInitialValues(storage);
      final adapter = FakeHttpClientAdapter(
        (options) => ResponseBody.fromString(
          '{"user":{"id":"user-1","tenantId":"tenant-1"},"tokens":{"accessToken":"nested-access","refreshToken":"nested-refresh"}}',
          200,
          headers: jsonHeaders,
        ),
      );
      final repository = SecureAuthRepository(api: _authApi(adapter));

      final session = await repository.login(
        email: 'admin@example.invalid',
        password: 'admin1234',
      );

      expect(adapter.requests.single.path, '/auth/login');
      expect(session.accessToken, 'nested-access');
      expect(session.refreshToken, 'nested-refresh');
      expect(session.tenantId, 'tenant-1');
      expect(session.userId, 'user-1');
      expect(storage['auth.accessToken'], 'nested-access');
      expect(storage['auth.refreshToken'], 'nested-refresh');
      expect(storage['auth.tenantId'], 'tenant-1');
      expect(storage['auth.userId'], 'user-1');
    });

    test('login forwards the tenant slug for SaaS tenant selection', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final adapter = FakeHttpClientAdapter(
        (options) => ResponseBody.fromString(
          '{"accessToken":"online-access","refreshToken":"online-refresh"}',
          200,
          headers: jsonHeaders,
        ),
      );
      final repository = SecureAuthRepository(api: _authApi(adapter));

      await repository.login(
        email: 'tech@example.ch',
        password: 'correct-password',
        tenantSlug: 'demo-kaminfeger',
      );

      expect(adapter.requests.single.data, {
        'email': 'tech@example.ch',
        'password': 'correct-password',
        'tenantSlug': 'demo-kaminfeger',
      });
    });

    test(
      'login uses configured default tenant slug when none is supplied',
      () async {
        FlutterSecureStorage.setMockInitialValues({});
        final adapter = FakeHttpClientAdapter(
          (options) => ResponseBody.fromString(
            '{"accessToken":"online-access","refreshToken":"online-refresh"}',
            200,
            headers: jsonHeaders,
          ),
        );
        final repository = SecureAuthRepository(
          api: _authApi(adapter),
          defaultTenantSlug: 'configured-tenant',
        );

        await repository.login(
          email: 'tech@example.ch',
          password: 'correct-password',
        );

        expect(adapter.requests.single.data, {
          'email': 'tech@example.ch',
          'password': 'correct-password',
          'tenantSlug': 'configured-tenant',
        });
      },
    );

    test(
      'refresh without a stored session reports an expired session',
      () async {
        FlutterSecureStorage.setMockInitialValues({});
        final adapter = FakeHttpClientAdapter(
          (_) => ResponseBody.fromString(
            '{"accessToken":"unused","refreshToken":"unused"}',
            200,
            headers: jsonHeaders,
          ),
        );
        final repository = SecureAuthRepository(api: _authApi(adapter));

        await expectLater(
          repository.refresh(),
          throwsA(
            isA<AuthError>().having(
              (error) => error.message,
              'message',
              'No session to refresh.',
            ),
          ),
        );
        expect(adapter.requests, isEmpty);
      },
    );

    test(
      'expired refresh keeps the previous session in secure storage',
      () async {
        final storage = <String, String>{
          'auth.email': 'tech@example.ch',
          'auth.accessToken': 'old-access',
          'auth.refreshToken': 'expired-refresh',
        };
        FlutterSecureStorage.setMockInitialValues(storage);
        final repository = SecureAuthRepository(
          api: _authApiWithStatus(401, '{"message":"expired refresh token"}'),
        );

        await expectLater(
          repository.refresh(),
          throwsA(
            isA<AuthError>().having(
              (error) => error.message,
              'message',
              'Session refresh failed.',
            ),
          ),
        );

        expect(storage['auth.email'], 'tech@example.ch');
        expect(storage['auth.accessToken'], 'old-access');
        expect(storage['auth.refreshToken'], 'expired-refresh');
      },
    );

    test('successful refresh updates stored tokens', () async {
      final storage = <String, String>{
        'auth.email': 'tech@example.ch',
        'auth.accessToken': 'old-access',
        'auth.refreshToken': 'old-refresh',
      };
      FlutterSecureStorage.setMockInitialValues(storage);
      final repository = SecureAuthRepository(
        api: _authApiWithStatus(
          200,
          '{"accessToken":"new-access","refreshToken":"new-refresh"}',
        ),
      );

      final session = await repository.refresh();

      expect(session.email, 'tech@example.ch');
      expect(session.accessToken, 'new-access');
      expect(session.refreshToken, 'new-refresh');
      expect(storage['auth.accessToken'], 'new-access');
      expect(storage['auth.refreshToken'], 'new-refresh');
    });
  });
}

AuthApi _authApiWithStatus(int statusCode, String body) {
  return _authApi(
    FakeHttpClientAdapter(
      (_) => ResponseBody.fromString(body, statusCode, headers: jsonHeaders),
    ),
  );
}

AuthApi _authApi(HttpClientAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://auth.test'));
  dio.httpClientAdapter = adapter;
  return AuthApi(
    ApiClient(
      environment: AppEnvironment.fromFlavor(
        AppFlavor.dev,
        apiBaseUrl: Uri.parse('https://auth.test'),
      ),
      dio: dio,
    ),
  );
}
