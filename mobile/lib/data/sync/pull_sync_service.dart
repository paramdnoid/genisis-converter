import 'package:drift/drift.dart';

import '../db/app_database.dart';

final class PullSyncService {
  const PullSyncService({required this.database});

  final AppDatabase database;

  Future<void> pull({required String tenantId}) async {
    final states = await database.syncStateDao.watchForTenant(tenantId).first;
    final now = DateTime.now().toUtc().toIso8601String();

    for (final state in states) {
      await database
          .into(database.syncStates)
          .insertOnConflictUpdate(
            state.copyWith(
              lastPullAt: Value(now),
              lastSuccessfulSyncAt: Value(now),
            ),
          );
    }
  }
}
