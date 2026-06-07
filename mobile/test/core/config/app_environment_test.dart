import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/core/logging/log_level.dart';

void main() {
  group('AppEnvironment', () {
    test('uses development defaults', () {
      final environment = AppEnvironment.fromFlavor(AppFlavor.dev);

      expect(environment.flavor, AppFlavor.dev);
      expect(environment.label, 'Development');
      expect(environment.logLevel, LogLevel.debug);
      expect(environment.enforceHttps, isFalse);
      expect(environment.allowsConfiguredEndpoint, isTrue);
    });

    test('enforces HTTPS for staging and production defaults', () {
      final staging = AppEnvironment.fromFlavor(AppFlavor.staging);
      final production = AppEnvironment.fromFlavor(AppFlavor.prod);

      expect(staging.enforceHttps, isTrue);
      expect(staging.allowsConfiguredEndpoint, isTrue);
      expect(production.enforceHttps, isTrue);
      expect(production.allowsConfiguredEndpoint, isTrue);
    });

    test('detects an invalid endpoint when HTTPS is enforced', () {
      final environment = AppEnvironment.fromFlavor(
        AppFlavor.prod,
        apiBaseUrl: Uri.parse('http://localhost:8080'),
      );

      expect(environment.enforceHttps, isTrue);
      expect(environment.isHttpsEndpoint, isFalse);
      expect(environment.allowsConfiguredEndpoint, isFalse);
    });

    test('parses flavor aliases and falls back to development', () {
      expect(AppFlavor.parse('development'), AppFlavor.dev);
      expect(AppFlavor.parse('stage'), AppFlavor.staging);
      expect(AppFlavor.parse('production'), AppFlavor.prod);
      expect(AppFlavor.parse('unknown'), AppFlavor.dev);
    });

    test('fromDartDefines defaults to local development values', () {
      final environment = AppEnvironment.fromDartDefines();

      expect(environment.flavor, AppFlavor.dev);
      expect(environment.logLevel, LogLevel.debug);
      expect(environment.apiBaseUrl, Uri.parse('https://api.example.invalid'));
    });
  });
}
