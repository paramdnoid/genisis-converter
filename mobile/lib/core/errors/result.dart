import 'app_error.dart';

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull {
    return switch (this) {
      Success<T>(:final value) => value,
      Failure<T>() => null,
    };
  }

  AppError? get errorOrNull {
    return switch (this) {
      Success<T>() => null,
      Failure<T>(:final error) => error,
    };
  }

  R when<R>({
    required R Function(T value) success,
    required R Function(AppError error) failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success(value),
      Failure<T>(:final error) => failure(error),
    };
  }

  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success<T>(:final value) => Success<R>(transform(value)),
      Failure<T>(:final error) => Failure<R>(error),
    };
  }

  Result<R> flatMap<R>(Result<R> Function(T value) transform) {
    return switch (this) {
      Success<T>(:final value) => transform(value),
      Failure<T>(:final error) => Failure<R>(error),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppError error;
}
