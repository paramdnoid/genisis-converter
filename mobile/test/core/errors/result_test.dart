import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';
import 'package:kaminfeger_mobile/core/errors/result.dart';

void main() {
  group('Result', () {
    test('exposes success values and maps them', () {
      const result = Success<int>(2);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.valueOrNull, 2);
      expect(result.errorOrNull, isNull);
      expect(result.map((value) => value * 2).valueOrNull, 4);
      expect(result.flatMap((value) => Success('$value')).valueOrNull, '2');
    });

    test('exposes failure errors and keeps them through mapping', () {
      const error = ValidationError(message: 'Missing title.');
      const result = Failure<int>(error);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.errorOrNull, same(error));
      expect(result.map((value) => value * 2).errorOrNull, same(error));
      expect(
        result.flatMap((value) => Success('$value')).errorOrNull,
        same(error),
      );
    });

    test('branches with when', () {
      const success = Success<String>('saved');
      const failure = Failure<String>(DatabaseError());

      expect(
        success.when(success: (value) => value, failure: (_) => 'failed'),
        'saved',
      );
      expect(
        failure.when(
          success: (value) => value,
          failure: (error) => error.code.name,
        ),
        'database',
      );
    });
  });
}
