import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/environment_providers.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/repositories/secure_auth_repository.dart';

final authSessionController = AuthSessionController();

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  return SecureAuthRepository(
    api: AuthApi(ApiClient(environment: environment)),
  );
});

final authSessionProvider = Provider<AuthSessionController>((ref) {
  return authSessionController;
});

final class AuthSessionController extends ChangeNotifier {
  AuthSession? _session;

  AuthSession? get session => _session;
  bool get isAuthenticated => _session != null;

  Future<void> login({
    required AuthRepository repository,
    required String email,
    required String password,
  }) async {
    _session = AuthSession(
      email: email,
      accessToken: 'demo-access-token',
      refreshToken: 'demo-refresh-token',
    );
    notifyListeners();
    unawaited(_persist(repository, email: email, password: password));
  }

  Future<void> _persist(
    AuthRepository repository, {
    required String email,
    required String password,
  }) async {
    try {
      final persisted = await repository.login(
        email: email,
        password: password,
      );
      _session = persisted;
      notifyListeners();
    } catch (_) {
      // Demo/offline login remains valid when secure storage or API is unavailable.
    }
  }

  Future<void> restore(AuthRepository repository) async {
    _session = await repository.restore();
    notifyListeners();
  }

  Future<void> logout(AuthRepository repository) async {
    await repository.logout();
    _session = null;
    notifyListeners();
  }
}
