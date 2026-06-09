// ignore_for_file: prefer_initializing_formals

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/errors/app_error.dart';
import '../api/auth_api.dart';

final class AuthSession {
  const AuthSession({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    this.tenantId,
    this.userId,
  });

  final String email;
  final String accessToken;
  final String refreshToken;
  final String? tenantId;
  final String? userId;
}

abstract interface class AuthRepository {
  Future<AuthSession> login({
    required String email,
    required String password,
    String? tenantSlug,
    String? tenantId,
  });

  Future<AuthSession?> restore();
  Future<void> logout();
  Future<AuthSession> refresh();
}

final class SecureAuthRepository implements AuthRepository {
  // Keep the public constructor label readable instead of exposing `_api`.
  const SecureAuthRepository({
    required AuthApi api,
    FlutterSecureStorage? storage,
    String? defaultTenantSlug,
    String? defaultTenantId,
  }) : _api = api,
       _storage = storage ?? const FlutterSecureStorage(),
       _defaultTenantSlug = defaultTenantSlug,
       _defaultTenantId = defaultTenantId;

  static const _emailKey = 'auth.email';
  static const _accessKey = 'auth.accessToken';
  static const _refreshKey = 'auth.refreshToken';
  static const _tenantIdKey = 'auth.tenantId';
  static const _userIdKey = 'auth.userId';

  final AuthApi _api;
  final FlutterSecureStorage _storage;
  final String? _defaultTenantSlug;
  final String? _defaultTenantId;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
    String? tenantSlug,
    String? tenantId,
  }) async {
    final tokens = await _api.login(
      email: email,
      password: password,
      tenantSlug: tenantSlug ?? _defaultTenantSlug,
      tenantId: tenantId ?? _defaultTenantId,
    );
    final session = AuthSession(
      email: email,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      tenantId: tokens.tenantId,
      userId: tokens.userId,
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
      final tenantId = await _storage.read(key: _tenantIdKey);
      final userId = await _storage.read(key: _userIdKey);
      if (email == null || access == null || refresh == null) {
        return null;
      }
      return AuthSession(
        email: email,
        accessToken: access,
        refreshToken: refresh,
        tenantId: tenantId,
        userId: userId,
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
    await _storage.delete(key: _tenantIdKey);
    await _storage.delete(key: _userIdKey);
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
      tenantId: tokens.tenantId ?? current.tenantId,
      userId: tokens.userId ?? current.userId,
    );
    await _write(next);
    return next;
  }

  Future<void> _write(AuthSession session) async {
    await _storage.write(key: _emailKey, value: session.email);
    await _storage.write(key: _accessKey, value: session.accessToken);
    await _storage.write(key: _refreshKey, value: session.refreshToken);
    if (session.tenantId != null) {
      await _storage.write(key: _tenantIdKey, value: session.tenantId);
    }
    if (session.userId != null) {
      await _storage.write(key: _userIdKey, value: session.userId);
    }
  }
}
