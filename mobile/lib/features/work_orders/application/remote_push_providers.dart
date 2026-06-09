import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/environment_providers.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/push_api.dart';
import '../../auth/application/auth_providers.dart';
import 'remote_push_registration_service.dart';

final pushTokenProvider = Provider<PushTokenProvider>((ref) {
  final config = RemotePushFirebaseConfig.fromDartDefines();
  if (!config.isComplete) {
    return const DisabledPushTokenProvider();
  }
  return FirebasePushTokenProvider(config: config);
});

final pushApiProvider = Provider<PushApi>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  final session = ref.watch(authSessionProvider).session;
  return PushApi(
    ApiClient(
      environment: environment,
      accessTokenProvider: () => session?.accessToken,
    ),
  );
});

final remotePushRegistrationServiceProvider =
    Provider<RemotePushRegistrationService>((ref) {
      return RemotePushRegistrationService(
        api: ref.watch(pushApiProvider),
        tokenProvider: ref.watch(pushTokenProvider),
      );
    });

final remotePushBootstrapProvider = FutureProvider<PushRegistrationResult>((
  ref,
) async {
  final session = ref.watch(authSessionProvider).session;
  final service = ref.watch(remotePushRegistrationServiceProvider);

  if (session == null || session.accessToken == 'demo-access-token') {
    return const PushRegistrationResult.skipped('no_online_session');
  }

  final refreshSubscription = ref
      .watch(pushTokenProvider)
      .tokenRefreshes
      .listen(
        (token) => unawaited(service.registerToken(session, token)),
        onError: (_) {},
      );
  ref.onDispose(refreshSubscription.cancel);

  return service.registerCurrentToken(session);
});
