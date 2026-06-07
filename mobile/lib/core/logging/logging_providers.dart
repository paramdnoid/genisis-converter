import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/environment_providers.dart';
import 'logging_service.dart';

final loggingServiceProvider = Provider<LoggingService>((ref) {
  final environment = ref.watch(appEnvironmentProvider);

  return ConsoleLoggingService(
    minimumLevel: environment.logLevel,
    includeVerboseContext: environment.isDevelopment,
  );
});
