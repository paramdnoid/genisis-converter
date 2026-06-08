// ignore_for_file: prefer_initializing_formals

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/errors/app_error.dart';
import '../api/auth_api.dart';

final class AuthSession {
  const AuthSession({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  final String email;
  final String accessToken;
  final String refreshToken;
}

abstract interface class AuthRepository {
  Future<AuthSession> login({required String email, required String password});

  Future<AuthSession?> restore();
  Future<void> logout();
  Future<AuthSession> refresh();
}

final class SecureAuthRepository implements AuthRepository {
  // Keep the public constructor label readable instead of exposing `_api`.
  const SecureAuthRepository({
    required AuthApi api,
    FlutterSecureStorage? storage,
  }) : _api = api,
       _storage = storage ?? const FlutterSecureStorage();

  static const _emailKey = 'auth.email';
  static const _accessKey = 'auth.accessToken';
  static const _refreshKey = 'auth.refreshToken';

  final AuthApi _api;
  final FlutterSecureStorage _storage;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final tokens = await _api.login(email: email, password: password);
    final session = AuthSession(
      email: email,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _write(session);
    return session;
  }

  @override
  Future<AuthSession?> restore() async {
    try {
      final email = await _storage.read(key: _emailKey);
      final access = await _storage.read(key: _accessKey);
      final refresh = await _storage.read(key: _refreshKey);
      if (email == null || access == null || refresh == null) {
        return null;
      }
      return AuthSession(
        email: email,
        accessToken: access,
        refreshToken: refresh,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }

  @override
  Future<AuthSession> refresh() async {
    final current = await restore();
    if (current == null) {
      throw const AuthError(message: 'No session to refresh.');
    }
    final tokens = await _api.refresh(current.refreshToken);
    final next = AuthSession(
      email: current.email,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _write(next);
    return next;
  }

  Future<void> _write(AuthSession session) async {
    await _storage.write(key: _emailKey, value: session.email);
    await _storage.write(key: _accessKey, value: session.accessToken);
    await _storage.write(key: _refreshKey, value: session.refreshToken);
  }
}
