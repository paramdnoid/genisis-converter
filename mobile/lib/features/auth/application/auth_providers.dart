import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/config/environment_providers.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/db/app_database.dart';
import '../../../data/repositories/secure_auth_repository.dart';

final authSessionController = AuthSessionController();

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  return SecureAuthRepository(
    api: AuthApi(ApiClient(environment: environment)),
    defaultTenantSlug: environment.tenantSlug,
  );
});

final authSessionProvider = ChangeNotifierProvider<AuthSessionController>((
  ref,
) {
  return authSessionController;
}, disposeNotifier: false);

final class AuthSessionController extends ChangeNotifier {
  AuthSession? _session;
  var _sessionRevision = 0;

  AuthSession? get session => _session;
  bool get isAuthenticated => _session != null;

  Future<void> login({
    required AuthRepository repository,
    required String email,
    required String password,
  }) async {
    final revision = ++_sessionRevision;
    _session = _demoSession(email);
    notifyListeners();

    unawaited(
      _persistLogin(
        repository: repository,
        email: email,
        password: password,
        revision: revision,
      ),
    );
  }

  Future<void> _persistLogin({
    required AuthRepository repository,
    required String email,
    required String password,
    required int revision,
  }) async {
    try {
      final persisted = await repository.login(
        email: email,
        password: password,
      );
      if (revision != _sessionRevision) {
        return;
      }
      _session = _withDemoFallbacks(persisted);
      notifyListeners();
    } catch (_) {
      // Demo/offline login remains valid when secure storage or API is unavailable.
    }
  }

  Future<void> restore(AuthRepository repository) async {
    _sessionRevision += 1;
    _session = await repository.restore();
    notifyListeners();
  }

  Future<void> logout(AuthRepository repository) async {
    _sessionRevision += 1;
    await repository.logout();
    _session = null;
    notifyListeners();
  }

  AuthSession _demoSession(String email) {
    return AuthSession(
      email: email,
      accessToken: 'demo-access-token',
      refreshToken: 'demo-refresh-token',
      tenantId: DevelopmentSeed.tenantId,
      userId: DevelopmentSeed.technicianUserId,
    );
  }

  AuthSession _withDemoFallbacks(AuthSession session) {
    return AuthSession(
      email: session.email,
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
      tenantId: session.tenantId ?? DevelopmentSeed.tenantId,
      userId: session.userId ?? DevelopmentSeed.technicianUserId,
    );
  }
}
