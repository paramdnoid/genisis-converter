import '../logging/log_level.dart';

enum AppFlavor {
  dev('Development'),
  staging('Staging'),
  prod('Production');

  const AppFlavor(this.label);

  final String label;

  static AppFlavor parse(String value) {
    return switch (value.trim().toLowerCase()) {
      'dev' || 'development' || 'local' => AppFlavor.dev,
      'stage' || 'staging' => AppFlavor.staging,
      'prod' || 'production' => AppFlavor.prod,
      _ => AppFlavor.dev,
    };
  }
}

final class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.apiBaseUrl,
    required this.logLevel,
    required this.enforceHttps,
  });

  factory AppEnvironment.fromFlavor(
    AppFlavor flavor, {
    Uri? apiBaseUrl,
    LogLevel? logLevel,
    bool? enforceHttps,
  }) {
    return switch (flavor) {
      AppFlavor.dev => AppEnvironment(
        flavor: flavor,
        apiBaseUrl: apiBaseUrl ?? Uri.parse('https://api.example.invalid'),
        logLevel: logLevel ?? LogLevel.debug,
        enforceHttps: enforceHttps ?? false,
      ),
      AppFlavor.staging => AppEnvironment(
        flavor: flavor,
        apiBaseUrl:
            apiBaseUrl ?? Uri.parse('https://staging-api.example.invalid'),
        logLevel: logLevel ?? LogLevel.info,
        enforceHttps: enforceHttps ?? true,
      ),
      AppFlavor.prod => AppEnvironment(
        flavor: flavor,
        apiBaseUrl: apiBaseUrl ?? Uri.parse('https://api.example.invalid'),
        logLevel: logLevel ?? LogLevel.warning,
        enforceHttps: enforceHttps ?? true,
      ),
    };
  }

  factory AppEnvironment.fromDartDefines() {
    const rawFlavor = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const rawApiBaseUrl = String.fromEnvironment('API_BASE_URL');
    const rawLogLevel = String.fromEnvironment('LOG_LEVEL');
    const rawDebugLogging = String.fromEnvironment('SYNC_DEBUG_LOGGING');
    const rawEnforceHttps = String.fromEnvironment('ENFORCE_HTTPS');

    final flavor = AppFlavor.parse(rawFlavor);
    final defaults = AppEnvironment.fromFlavor(flavor);

    return AppEnvironment(
      flavor: flavor,
      apiBaseUrl: rawApiBaseUrl.trim().isEmpty
          ? defaults.apiBaseUrl
          : Uri.parse(rawApiBaseUrl),
      logLevel: _resolveLogLevel(
        rawLogLevel: rawLogLevel,
        rawDebugLogging: rawDebugLogging,
        fallback: defaults.logLevel,
      ),
      enforceHttps: _parseBool(rawEnforceHttps) ?? defaults.enforceHttps,
    );
  }

  final AppFlavor flavor;
  final Uri apiBaseUrl;
  final LogLevel logLevel;
  final bool enforceHttps;

  String get label => flavor.label;
  bool get isDevelopment => flavor == AppFlavor.dev;
  bool get isHttpsEndpoint => apiBaseUrl.scheme == 'https';
  bool get allowsConfiguredEndpoint => !enforceHttps || isHttpsEndpoint;

  static LogLevel _resolveLogLevel({
    required String rawLogLevel,
    required String rawDebugLogging,
    required LogLevel fallback,
  }) {
    if (rawLogLevel.trim().isNotEmpty) {
      return LogLevel.parse(rawLogLevel, fallback: fallback);
    }

    final debugLogging = _parseBool(rawDebugLogging);
    if (debugLogging == true) {
      return LogLevel.debug;
    }

    return fallback;
  }

  static bool? _parseBool(String value) {
    return switch (value.trim().toLowerCase()) {
      'true' || '1' || 'yes' || 'y' => true,
      'false' || '0' || 'no' || 'n' => false,
      _ => null,
    };
  }
}
