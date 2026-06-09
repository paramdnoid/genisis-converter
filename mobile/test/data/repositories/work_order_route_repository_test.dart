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
    'loads today route stops with local object address and coordinates',
    () async {
      final stops = await repository.watchTodayRouteStops(DateTime.now()).first;

      expect(stops, hasLength(2));
      expect(stops.map((stop) => stop.workOrder.orderNumber), [
        'WO-2026-0001',
        'WO-2026-0002',
      ]);
      expect(stops.first.object.name, 'Einfamilienhaus Keller');
      expect(stops.first.address, 'Im Ried 7, 8610 Uster');
      expect(stops.first.coordinate?.latitude, 47.349962);
      expect(stops.first.coordinate?.longitude, 8.718269);
    },
  );
}
