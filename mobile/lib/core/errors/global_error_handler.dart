import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/app_environment.dart';
import '../logging/logging_service.dart';

final class GlobalErrorHandler {
  GlobalErrorHandler({required this.logger});

  final LoggingService logger;

  void install() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      logger.error(
        'Unhandled Flutter error',
        error: details.exception,
        stackTrace: details.stack,
      );
    };
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      logger.error(
        'Unhandled platform error',
        error: error,
        stackTrace: stackTrace,
      );
      return true;
    };
  }

  static void runAppGuarded(Widget app) {
    final environment = AppEnvironment.fromDartDefines();
    final handler = GlobalErrorHandler(
      logger: ConsoleLoggingService(
        minimumLevel: environment.logLevel,
        includeVerboseContext: environment.isDevelopment,
      ),
    );
    handler.install();

    runZonedGuarded(() => runApp(app), (error, stackTrace) {
      handler.logger.error(
        'Unhandled zone error',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }
}
