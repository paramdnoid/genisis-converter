import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/logging/log_level.dart';
import 'package:kaminfeger_mobile/core/logging/logging_service.dart';

void main() {
  group('ConsoleLoggingService', () {
    test('skips entries below the configured minimum level', () {
      final lines = <String>[];
      final logger = ConsoleLoggingService(
        minimumLevel: LogLevel.info,
        includeVerboseContext: true,
        output: lines.add,
      );

      logger.debug('Preparing sync');
      logger.info('Sync started');

      expect(lines, hasLength(1));
      expect(lines.single, contains('INFO'));
      expect(lines.single, contains('Sync started'));
    });

    test('redacts sensitive values from message and context', () {
      final lines = <String>[];
      final logger = ConsoleLoggingService(
        minimumLevel: LogLevel.debug,
        includeVerboseContext: true,
        output: lines.add,
      );

      logger.debug(
        'Login response token=plain-token-value',
        context: {
          'accessToken': 'access-token-value',
          'safeValue': 'visible',
          'nested': {'password': 'password-value', 'count': 2},
          'items': [
            {'refreshToken': 'refresh-token-value'},
          ],
        },
      );

      expect(lines, hasLength(1));
      expect(lines.single, contains('[REDACTED]'));
      expect(lines.single, contains('visible'));
      expect(lines.single, contains('"count":2'));
      expect(lines.single, isNot(contains('plain-token-value')));
      expect(lines.single, isNot(contains('access-token-value')));
      expect(lines.single, isNot(contains('password-value')));
      expect(lines.single, isNot(contains('refresh-token-value')));
    });

    test('keeps error details out of non-verbose logging', () {
      final lines = <String>[];
      final logger = ConsoleLoggingService(
        minimumLevel: LogLevel.warning,
        includeVerboseContext: false,
        output: lines.add,
      );

      logger.warning('Network failed', error: Exception('socket closed'));

      expect(lines, hasLength(1));
      expect(lines.single, contains('Network failed'));
      expect(lines.single, isNot(contains('socket closed')));
    });
  });

  group('LogLevel', () {
    test('parses known values with fallback', () {
      expect(LogLevel.parse('debug'), LogLevel.debug);
      expect(LogLevel.parse('warn'), LogLevel.warning);
      expect(LogLevel.parse('none'), LogLevel.off);
      expect(
        LogLevel.parse('invalid', fallback: LogLevel.error),
        LogLevel.error,
      );
    });
  });
}
