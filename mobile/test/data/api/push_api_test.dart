import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/data/api/api_client.dart';
import 'package:kaminfeger_mobile/data/api/push_api.dart';

import '../../helpers/fake_http_client_adapter.dart';

void main() {
  test('registerDeviceToken posts the current FCM token with auth', () async {
    final adapter = FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200, headers: jsonHeaders),
    );
    final api = _pushApi(adapter, accessToken: 'online-access');

    await api.registerDeviceToken(
      token: 'fcm-token',
      platform: 'android',
      appVersion: '1.0.0+1',
    );

    final request = adapter.requests.single;
    expect(request.method, 'POST');
    expect(request.path, '/push/device-tokens');
    expect(request.headers['Authorization'], 'Bearer online-access');
    expect(request.data, {
      'token': 'fcm-token',
      'platform': 'android',
      'appVersion': '1.0.0+1',
    });
  });

  test('revokeDeviceToken deletes the token registration', () async {
    final adapter = FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200, headers: jsonHeaders),
    );
    final api = _pushApi(adapter);

    await api.revokeDeviceToken('fcm-token');

    final request = adapter.requests.single;
    expect(request.method, 'DELETE');
    expect(request.path, '/push/device-tokens');
    expect(request.data, {'token': 'fcm-token'});
  });
}

PushApi _pushApi(
  HttpClientAdapter adapter, {
  String accessToken = 'access-token',
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
  dio.httpClientAdapter = adapter;
  return PushApi(
    ApiClient(
      environment: AppEnvironment.fromFlavor(
        AppFlavor.dev,
        apiBaseUrl: Uri.parse('https://api.test'),
      ),
      dio: dio,
      accessTokenProvider: () => accessToken,
    ),
  );
}
