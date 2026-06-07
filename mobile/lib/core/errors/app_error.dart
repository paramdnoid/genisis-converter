enum AppErrorCode {
  network,
  auth,
  validation,
  database,
  syncConflict,
  fileStorage,
  permission,
  unexpected,
}

abstract class AppError implements Exception {
  const AppError({
    required this.code,
    required this.message,
    this.cause,
    this.stackTrace,
    this.metadata = const {},
  });

  final AppErrorCode code;
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
  final Map<String, Object?> metadata;

  String get userMessage => AppErrorMessages.forError(this);

  @override
  String toString() => '$runtimeType($code): $message';
}

final class NetworkError extends AppError {
  const NetworkError({
    super.message = 'Network request failed.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.network);
}

final class AuthError extends AppError {
  const AuthError({
    super.message = 'Authentication failed.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.auth);
}

final class ValidationError extends AppError {
  const ValidationError({
    super.message = 'Validation failed.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.validation);
}

final class DatabaseError extends AppError {
  const DatabaseError({
    super.message = 'Database operation failed.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.database);
}

final class SyncConflictError extends AppError {
  const SyncConflictError({
    super.message = 'Synchronization conflict detected.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.syncConflict);
}

final class FileStorageError extends AppError {
  const FileStorageError({
    super.message = 'File storage operation failed.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.fileStorage);
}

final class PermissionError extends AppError {
  const PermissionError({
    super.message = 'Required permission is missing.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.permission);
}

final class UnexpectedError extends AppError {
  const UnexpectedError({
    super.message = 'Unexpected error.',
    super.cause,
    super.stackTrace,
    super.metadata = const {},
  }) : super(code: AppErrorCode.unexpected);
}

abstract final class AppErrorMessages {
  static String forError(AppError error) {
    return switch (error.code) {
      AppErrorCode.network =>
        'Die Verbindung ist aktuell nicht verfügbar. Die App arbeitet lokal weiter.',
      AppErrorCode.auth =>
        'Die Anmeldung ist nicht gültig. Bitte melde dich erneut an.',
      AppErrorCode.validation => 'Bitte prüfe die Eingaben.',
      AppErrorCode.database =>
        'Lokale Daten konnten nicht gespeichert werden. Bitte versuche es erneut.',
      AppErrorCode.syncConflict =>
        'Es gibt einen Synchronisationskonflikt. Die lokalen Daten bleiben erhalten.',
      AppErrorCode.fileStorage =>
        'Die Datei konnte nicht verarbeitet werden. Bitte versuche es erneut.',
      AppErrorCode.permission =>
        'Eine benötigte Berechtigung fehlt. Bitte prüfe die App-Berechtigungen.',
      AppErrorCode.unexpected =>
        'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.',
    };
  }
}
