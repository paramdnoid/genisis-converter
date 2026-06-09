import 'package:dio/dio.dart';

import '../../core/errors/app_error.dart';
import 'api_client.dart';

final class PushApi {
  const PushApi(this._client);

  final ApiClient _client;

  Future<void> registerDeviceToken({
    required String token,
    required String platform,
    String? deviceId,
    String? appVersion,
  }) async {
    if (token.trim().isEmpty) {
      throw ArgumentError('Push token is required.');
    }
    if (platform.trim().isEmpty) {
      throw ArgumentError('Push platform is required.');
    }

    try {
      await _client.dio.post<Map<String, Object?>>(
        '/push/device-tokens',
        data: <String, Object?>{
          'token': token,
          'platform': platform,
          if (deviceId != null && deviceId.trim().isNotEmpty)
            'deviceId': deviceId,
          if (appVersion != null && appVersion.trim().isNotEmpty)
            'appVersion': appVersion,
        },
      );
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
        message: 'Push token registration failed.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> revokeDeviceToken(String token) async {
    if (token.trim().isEmpty) {
      return;
    }

    try {
      await _client.dio.delete<Map<String, Object?>>(
        '/push/device-tokens',
        data: <String, Object?>{'token': token},
      );
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
        message: 'Push token revocation failed.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }
}
