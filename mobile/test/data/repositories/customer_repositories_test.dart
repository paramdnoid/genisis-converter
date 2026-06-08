import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_customer_object_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_customer_repository.dart';

void main() {
  late AppDatabase database;
  late DriftCustomerRepository customerRepository;
  late DriftCustomerObjectRepository objectRepository;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
    customerRepository = DriftCustomerRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    objectRepository = DriftCustomerObjectRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'customer repository exposes active customers and detail aggregate',
    () async {
      final customers = await customerRepository.watchAll().first;
      final detail = await customerRepository.getDetail(
        DevelopmentSeed.customerId,
      );

      expect(
        customers.map((customer) => customer.displayName),
        contains('Familie Keller'),
      );
      expect(detail, isNotNull);
      expect(detail!.customer.displayName, 'Familie Keller');
      expect(
        detail.objects.map((object) => object.name),
        contains('Einfamilienhaus Keller'),
      );
      expect(
        detail.history.map((order) => order.orderNumber),
        contains('WO-2026-0001'),
      );
    },
  );

  test(
    'customer repository note updates stay local and enqueue outbox',
    () async {
      await customerRepository.updateNotes(
        id: DevelopmentSeed.customerId,
        notes: 'Schluessel beim Nachbarn deponiert.',
      );

      final customer = await customerRepository.getById(
        DevelopmentSeed.customerId,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(customer?.notes, 'Schluessel beim Nachbarn deponiert.');
      expect(pendingOutbox, hasLength(1));
      expect(pendingOutbox.single.entityType, 'customer');
      expect(pendingOutbox.single.operation, 'update');
    },
  );

  test('object repository exposes object detail aggregate', () async {
    final detail = await objectRepository.getDetail(DevelopmentSeed.objectId);

    expect(detail, isNotNull);
    expect(detail!.object.name, 'Einfamilienhaus Keller');
    expect(
      detail.installations.map((installation) => installation.displayName),
      contains('Rueegg RIII 45'),
    );
    expect(
      detail.history.map((order) => order.orderNumber),
      contains('WO-2026-0001'),
    );
  });

  test(
    'object repository note updates stay local and enqueue outbox',
    () async {
      await objectRepository.updateNotes(
        id: DevelopmentSeed.objectId,
        notes: 'Dachzugang nur mit langer Leiter.',
      );

      final object = await objectRepository.getById(DevelopmentSeed.objectId);
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(object?.objectNotes, 'Dachzugang nur mit langer Leiter.');
      expect(pendingOutbox, hasLength(1));
      expect(pendingOutbox.single.entityType, 'object');
      expect(pendingOutbox.single.operation, 'update');
    },
  );
}
