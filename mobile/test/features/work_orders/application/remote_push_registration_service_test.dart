import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/data/api/api_client.dart';
import 'package:kaminfeger_mobile/data/api/push_api.dart';
import 'package:kaminfeger_mobile/data/repositories/secure_auth_repository.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/remote_push_registration_service.dart';

import '../../../helpers/fake_http_client_adapter.dart';

void main() {
  test('registers the current FCM token for an online session', () async {
    final adapter = FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200, headers: jsonHeaders),
    );
    final service = RemotePushRegistrationService(
      api: _pushApi(adapter),
      tokenProvider: _FakePushTokenProvider(
        current: const RemotePushDeviceToken(
          token: 'fcm-token',
          platform: 'ios',
          appVersion: '1.0.0+1',
        ),
      ),
    );

    final result = await service.registerCurrentToken(_session());

    expect(result.status, PushRegistrationStatus.registered);
    expect(result.token, 'fcm-token');
    expect(adapter.requests.single.data, {
      'token': 'fcm-token',
      'platform': 'ios',
      'appVersion': '1.0.0+1',
    });
  });

  test('skips demo sessions without touching Firebase or the API', () async {
    final adapter = FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200, headers: jsonHeaders),
    );
    final tokenProvider = _FakePushTokenProvider(
      current: const RemotePushDeviceToken(
        token: 'unused',
        platform: 'android',
      ),
    );
    final service = RemotePushRegistrationService(
      api: _pushApi(adapter),
      tokenProvider: tokenProvider,
    );

    final result = await service.registerCurrentToken(
      _session(accessToken: 'demo-access-token'),
    );

    expect(result.status, PushRegistrationStatus.skipped);
    expect(result.reason, 'no_online_session');
    expect(tokenProvider.currentTokenCalls, 0);
    expect(adapter.requests, isEmpty);
  });

  test('skips registration when Firebase is not configured', () async {
    final adapter = FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200, headers: jsonHeaders),
    );
    final service = RemotePushRegistrationService(
      api: _pushApi(adapter),
      tokenProvider: _FakePushTokenProvider(),
    );

    final result = await service.registerCurrentToken(_session());

    expect(result.status, PushRegistrationStatus.skipped);
    expect(result.reason, 'push_not_configured');
    expect(adapter.requests, isEmpty);
  });
}

AuthSession _session({String accessToken = 'online-access'}) {
  return AuthSession(
    email: 'tech@example.ch',
    accessToken: accessToken,
    refreshToken: 'refresh-token',
    tenantId: 'tenant-1',
    userId: 'technician-1',
  );
}

PushApi _pushApi(HttpClientAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
  dio.httpClientAdapter = adapter;
  return PushApi(
    ApiClient(
      environment: AppEnvironment.fromFlavor(
        AppFlavor.dev,
        apiBaseUrl: Uri.parse('https://api.test'),
      ),
      dio: dio,
      accessTokenProvider: () => 'online-access',
    ),
  );
}

final class _FakePushTokenProvider implements PushTokenProvider {
  _FakePushTokenProvider({this.current});

  final RemotePushDeviceToken? current;
  var currentTokenCalls = 0;

  @override
  Future<RemotePushDeviceToken?> currentToken() async {
    currentTokenCalls += 1;
    return current;
  }

  @override
  Stream<RemotePushDeviceToken> get tokenRefreshes => const Stream.empty();
}
