import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_work_order_repository.dart';

void main() {
  late AppDatabase database;
  late DriftWorkOrderRepository repository;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
    repository = DriftWorkOrderRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
      userId: DevelopmentSeed.technicianUserId,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'creates due recurring work orders once and advances interval',
    () async {
      final dueDate = DateTime.now();
      final dueIso = DateTime(
        dueDate.year,
        dueDate.month,
        dueDate.day,
        9,
      ).toUtc().toIso8601String();
      await database
          .into(database.installations)
          .insert(
            InstallationsCompanion.insert(
              id: 'aaaaaaaa-bbbb-4ccc-8ddd-eeeeeeeeeeee',
              tenantId: DevelopmentSeed.tenantId,
              objectId: DevelopmentSeed.objectId,
              type: 'boiler',
              manufacturer: const Value('Hoval'),
              model: const Value('UltraGas 30'),
              fuelType: const Value('gas'),
              locationDescription: const Value('Keller Technikraum'),
              intervalMonths: const Value(6),
              nextServiceDate: Value(dueIso),
              createdAt: Value(DateTime.now().toUtc().toIso8601String()),
              updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
            ),
          );

      final candidates = await repository
          .watchDueRecurringCandidates(DateTime.now())
          .first;

      expect(candidates, hasLength(1));
      expect(candidates.single.installation.displayName, 'Hoval UltraGas 30');
      expect(candidates.single.object.name, 'Einfamilienhaus Keller');

      final created = await repository.createDueRecurringWorkOrders(
        DateTime.now(),
      );

      expect(created, hasLength(1));
      expect(created.single.type, 'recurring_service');
      expect(created.single.orderNumber, startsWith('WO-REC-'));
      expect(created.single.title, 'Wiederkehrende Arbeit Hoval UltraGas 30');
      expect(created.single.syncStatus, 'pending');

      final linkedHistory = await database.workOrderDao
          .watchForInstallation(
            DevelopmentSeed.tenantId,
            candidates.single.installation.id,
          )
          .first;
      expect(
        linkedHistory.map((order) => order.orderNumber),
        contains(created.single.orderNumber),
      );

      final updatedInstallation = await database.installationDao.getById(
        candidates.single.installation.id,
      );
      expect(updatedInstallation, isNotNull);
      expect(updatedInstallation!.syncStatus, 'pending');
      expect(
        DateTime.parse(
          updatedInstallation.nextServiceDate!,
        ).isAfter(DateTime.now()),
        isTrue,
      );

      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;
      expect(
        pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
        containsAll([
          'work_order:create',
          'work_order_installation:create',
          'installation:update',
        ]),
      );

      final secondRun = await repository.createDueRecurringWorkOrders(
        DateTime.now(),
      );
      expect(secondRun, isEmpty);
    },
  );
}
