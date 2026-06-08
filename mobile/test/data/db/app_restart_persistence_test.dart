import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:path/path.dart' as path;

void main() {
  test('local changes survive database close and reopen', () async {
    final root = await Directory.systemTemp.createTemp('app_restart_test_');
    final dbFile = File(path.join(root.path, 'app.sqlite'));

    try {
      var database = AppDatabase.forTesting(NativeDatabase(dbFile));
      await database.seedDevelopmentData();
      await database.customerDao.updateNotesLocal(
        id: DevelopmentSeed.customerId,
        notes: 'Bleibt nach Neustart erhalten',
      );
      await database.close();

      database = AppDatabase.forTesting(NativeDatabase(dbFile));
      final customer = await database.customerDao.getById(
        DevelopmentSeed.customerId,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(customer?.notes, 'Bleibt nach Neustart erhalten');
      expect(customer?.syncStatus, 'pending');
      expect(pendingOutbox, hasLength(1));
      expect(pendingOutbox.single.entityType, 'customer');
      expect(pendingOutbox.single.entityId, DevelopmentSeed.customerId);

      await database.close();
    } finally {
      if (await root.exists()) {
        await root.delete(recursive: true);
      }
    }
  });
}
