import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';

void main() {
  group('AppError', () {
    test('creates typed errors with stable code and metadata', () {
      const error = NetworkError(
        message: 'No connection.',
        metadata: {'entityType': 'workOrder'},
      );

      expect(error.code, AppErrorCode.network);
      expect(error.message, 'No connection.');
      expect(error.metadata['entityType'], 'workOrder');
      expect(error.userMessage, contains('Verbindung'));
    });

    test('maps every error type to a user-facing message', () {
      const errors = <AppError>[
        NetworkError(),
        AuthError(),
        ValidationError(),
        DatabaseError(),
        SyncConflictError(),
        FileStorageError(),
        PermissionError(),
        UnexpectedError(),
      ];

      for (final error in errors) {
        expect(error.userMessage, isNotEmpty);
        expect(error.userMessage, isNot(contains(error.message)));
      }
    });
  });
}
