enum LogLevel {
  debug(0),
  info(1),
  warning(2),
  error(3),
  off(4);

  const LogLevel(this.priority);

  final int priority;

  bool allows(LogLevel level) => level.priority >= priority && this != off;

  static LogLevel parse(String value, {LogLevel fallback = LogLevel.info}) {
    return switch (value.trim().toLowerCase()) {
      'debug' => LogLevel.debug,
      'info' => LogLevel.info,
      'warning' || 'warn' => LogLevel.warning,
      'error' => LogLevel.error,
      'off' || 'none' => LogLevel.off,
      _ => fallback,
    };
  }
}
