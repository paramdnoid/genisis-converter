import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final databaseReadyProvider = FutureProvider<AppDatabase>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  await database.seedDevelopmentData();
  return database;
});
