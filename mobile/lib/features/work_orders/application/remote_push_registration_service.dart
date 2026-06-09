// ignore_for_file: prefer_initializing_formals

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../data/api/push_api.dart';
import '../../../data/repositories/secure_auth_repository.dart';

final class RemotePushFirebaseConfig {
  const RemotePushFirebaseConfig({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    this.iosBundleId,
    this.appVersion,
  });

  factory RemotePushFirebaseConfig.fromDartDefines() {
    const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
    const appId = String.fromEnvironment('FIREBASE_APP_ID');
    const messagingSenderId = String.fromEnvironment(
      'FIREBASE_MESSAGING_SENDER_ID',
    );
    const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
    const iosBundleId = String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID');
    const appVersion = String.fromEnvironment('APP_VERSION');

    return RemotePushFirebaseConfig(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      iosBundleId: iosBundleId.trim().isEmpty ? null : iosBundleId,
      appVersion: appVersion.trim().isEmpty ? null : appVersion,
    );
  }

  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String? iosBundleId;
  final String? appVersion;

  bool get isComplete {
    return apiKey.trim().isNotEmpty &&
        appId.trim().isNotEmpty &&
        messagingSenderId.trim().isNotEmpty &&
        projectId.trim().isNotEmpty;
  }

  FirebaseOptions toFirebaseOptions() {
    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      iosBundleId: iosBundleId,
    );
  }
}

final class RemotePushDeviceToken {
  const RemotePushDeviceToken({
    required this.token,
    required this.platform,
    this.appVersion,
  });

  final String token;
  final String platform;
  final String? appVersion;
}

abstract interface class PushTokenProvider {
  Future<RemotePushDeviceToken?> currentToken();
  Stream<RemotePushDeviceToken> get tokenRefreshes;
}

final class DisabledPushTokenProvider implements PushTokenProvider {
  const DisabledPushTokenProvider();

  @override
  Future<RemotePushDeviceToken?> currentToken() async => null;

  @override
  Stream<RemotePushDeviceToken> get tokenRefreshes => const Stream.empty();
}

final class FirebasePushTokenProvider implements PushTokenProvider {
  FirebasePushTokenProvider({required RemotePushFirebaseConfig config})
    : _config = config;

  final RemotePushFirebaseConfig _config;
  Future<bool>? _initialization;

  @override
  Future<RemotePushDeviceToken?> currentToken() async {
    if (!await _ensureInitialized()) {
      return null;
    }
    final platform = _platformName();
    if (platform == null) {
      return null;
    }

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.trim().isEmpty) {
      return null;
    }

    return RemotePushDeviceToken(
      token: token,
      platform: platform,
      appVersion: _config.appVersion,
    );
  }

  @override
  Stream<RemotePushDeviceToken> get tokenRefreshes async* {
    if (!await _ensureInitialized()) {
      return;
    }
    final platform = _platformName();
    if (platform == null) {
      return;
    }

    await for (final token in FirebaseMessaging.instance.onTokenRefresh) {
      if (token.trim().isEmpty) {
        continue;
      }
      yield RemotePushDeviceToken(
        token: token,
        platform: platform,
        appVersion: _config.appVersion,
      );
    }
  }

  Future<bool> _ensureInitialized() {
    return _initialization ??= _initialize();
  }

  Future<bool> _initialize() async {
    if (!_config.isComplete || _platformName() == null) {
      return false;
    }

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(options: _config.toFirebaseOptions());
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}

final class PushRegistrationResult {
  const PushRegistrationResult._({
    required this.status,
    this.reason,
    this.token,
  });

  const PushRegistrationResult.registered(String token)
    : this._(status: PushRegistrationStatus.registered, token: token);

  const PushRegistrationResult.skipped(String reason)
    : this._(status: PushRegistrationStatus.skipped, reason: reason);

  const PushRegistrationResult.failed(String reason)
    : this._(status: PushRegistrationStatus.failed, reason: reason);

  final PushRegistrationStatus status;
  final String? reason;
  final String? token;
}

enum PushRegistrationStatus { registered, skipped, failed }

final class RemotePushRegistrationService {
  const RemotePushRegistrationService({
    required PushApi api,
    required PushTokenProvider tokenProvider,
  }) : _api = api,
       _tokenProvider = tokenProvider;

  final PushApi _api;
  final PushTokenProvider _tokenProvider;

  Future<PushRegistrationResult> registerCurrentToken(
    AuthSession? session,
  ) async {
    if (!_isOnlineSession(session)) {
      return const PushRegistrationResult.skipped('no_online_session');
    }

    try {
      final token = await _tokenProvider.currentToken();
      if (token == null) {
        return const PushRegistrationResult.skipped('push_not_configured');
      }
      await registerToken(session!, token);
      return PushRegistrationResult.registered(token.token);
    } catch (_) {
      return const PushRegistrationResult.failed('registration_failed');
    }
  }

  Future<void> registerToken(AuthSession session, RemotePushDeviceToken token) {
    return _api.registerDeviceToken(
      token: token.token,
      platform: token.platform,
      appVersion: token.appVersion,
    );
  }

  bool _isOnlineSession(AuthSession? session) {
    return session != null &&
        session.accessToken.trim().isNotEmpty &&
        session.accessToken != 'demo-access-token';
  }
}

String? _platformName() {
  if (kIsWeb) {
    return 'web';
  }

  return switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    _ => null,
  };
}
