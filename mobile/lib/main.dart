import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/errors/global_error_handler.dart';

void main() {
  GlobalErrorHandler.runAppGuarded(const ProviderScope(child: KaminfegerApp()));
}
