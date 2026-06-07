import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'log_level.dart';

typedef LogOutput = void Function(String line);

abstract interface class LoggingService {
  LogLevel get minimumLevel;

  void debug(String message, {Map<String, Object?> context = const {}});

  void info(String message, {Map<String, Object?> context = const {}});

  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  });

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  });
}

final class ConsoleLoggingService implements LoggingService {
  ConsoleLoggingService({
    required this.minimumLevel,
    required this.includeVerboseContext,
    LogOutput? output,
  }) : _output = output ?? debugPrint;

  @override
  final LogLevel minimumLevel;

  final bool includeVerboseContext;
  final LogOutput _output;

  @override
  void debug(String message, {Map<String, Object?> context = const {}}) {
    _write(LogLevel.debug, message, context: context);
  }

  @override
  void info(String message, {Map<String, Object?> context = const {}}) {
    _write(LogLevel.info, message, context: context);
  }

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    _write(
      LogLevel.warning,
      message,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    _write(
      LogLevel.error,
      message,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );
  }

  void _write(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    if (!minimumLevel.allows(level)) {
      return;
    }

    final sanitizedContext = sanitizeLogContext(context);
    final timestamp = DateTime.now().toUtc().toIso8601String();
    final buffer = StringBuffer(
      '[$timestamp] ${level.name.toUpperCase()} ${_redactText(message)}',
    );

    if (sanitizedContext.isNotEmpty) {
      buffer.write(' ${jsonEncode(sanitizedContext)}');
    }

    if (includeVerboseContext && error != null) {
      buffer.write(' error=${_redactText(error.toString())}');
    }

    if (includeVerboseContext && stackTrace != null) {
      buffer.write(' stackTrace=${_redactText(stackTrace.toString())}');
    }

    _output(buffer.toString());
  }

  static Map<String, Object?> sanitizeLogContext(Map<String, Object?> context) {
    return context.map(
      (key, value) => MapEntry(key, _sanitizeValue(value, key: key)),
    );
  }

  static Object? _sanitizeValue(Object? value, {String? key}) {
    if (_isSensitiveKey(key)) {
      return '[REDACTED]';
    }

    return switch (value) {
      null => null,
      String() => _redactText(value),
      Map() => value.map(
        (nestedKey, nestedValue) => MapEntry(
          nestedKey.toString(),
          _sanitizeValue(nestedValue, key: nestedKey.toString()),
        ),
      ),
      Iterable() => value.map(_sanitizeValue).toList(growable: false),
      _ => value,
    };
  }

  static bool _isSensitiveKey(String? key) {
    if (key == null) {
      return false;
    }

    final normalized = key.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    return normalized.contains('token') ||
        normalized.contains('password') ||
        normalized.contains('secret') ||
        normalized.contains('authorization') ||
        normalized.contains('apikey') ||
        normalized.contains('jwt') ||
        normalized.contains('credential') ||
        normalized.contains('cookie') ||
        normalized.contains('session') ||
        normalized.contains('privatekey') ||
        normalized.contains('filecontent');
  }

  static String _redactText(String text) {
    final sensitiveAssignment = RegExp(
      r'\b(access[_-]?token|refresh[_-]?token|token|password|secret|authorization|api[_-]?key|jwt|credential|cookie|session|private[_-]?key)\s*[:=]\s*([^\s,;]+)',
      caseSensitive: false,
    );

    return text.replaceAllMapped(sensitiveAssignment, (match) {
      return '${match.group(1)}=[REDACTED]';
    });
  }
}
