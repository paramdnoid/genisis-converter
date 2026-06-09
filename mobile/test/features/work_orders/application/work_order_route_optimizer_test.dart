import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/customer_object.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order_route_stop.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/work_order_route_optimizer.dart';

void main() {
  const optimizer = WorkOrderRouteOptimizer();

  test('orders route stops by nearest coordinate from origin', () {
    final stops = [
      _stop(
        orderNumber: 'WO-3',
        objectName: 'Basel',
        latitude: 47.5596,
        longitude: 7.5886,
        start: DateTime.utc(2026, 1, 1, 8),
      ),
      _stop(
        orderNumber: 'WO-1',
        objectName: 'Uster',
        latitude: 47.349962,
        longitude: 8.718269,
        start: DateTime.utc(2026, 1, 1, 9),
      ),
      _stop(
        orderNumber: 'WO-2',
        objectName: 'Winterthur',
        latitude: 47.4988,
        longitude: 8.7237,
        start: DateTime.utc(2026, 1, 1, 10),
      ),
    ];

    final plan = optimizer.plan(
      stops,
      origin: const RouteCoordinate(latitude: 47.3769, longitude: 8.5417),
    );

    expect(plan.optimizedByCoordinates, isTrue);
    expect(plan.stops.map((stop) => stop.object.name), [
      'Uster',
      'Winterthur',
      'Basel',
    ]);
    expect(plan.mapsUri.host, 'www.google.com');
    expect(plan.mapsUri.path, '/maps/dir/');
    expect(plan.mapsUri.queryParameters['travelmode'], 'driving');
    expect(plan.mapsUri.queryParameters['origin'], '47.376900,8.541700');
    expect(plan.mapsUri.queryParameters['destination'], '47.559600,7.588600');
    expect(
      plan.mapsUri.queryParameters['waypoints'],
      '47.349962,8.718269|47.498800,8.723700',
    );
  });

  test('falls back to schedule order when coordinates are incomplete', () {
    final stops = [
      _stop(
        orderNumber: 'WO-2',
        objectName: 'Second',
        latitude: null,
        longitude: null,
        start: DateTime.utc(2026, 1, 1, 10),
      ),
      _stop(
        orderNumber: 'WO-1',
        objectName: 'First',
        latitude: 47.349962,
        longitude: 8.718269,
        start: DateTime.utc(2026, 1, 1, 8),
      ),
    ];

    final plan = optimizer.plan(stops);

    expect(plan.optimizedByCoordinates, isFalse);
    expect(plan.stops.map((stop) => stop.workOrder.orderNumber), [
      'WO-1',
      'WO-2',
    ]);
    expect(plan.mapsUri.queryParameters['destination'], 'Street 2, 8000 City');
    expect(plan.mapsUri.queryParameters['waypoints'], '47.349962,8.718269');
  });

  test('requires at least one route stop', () {
    expect(() => optimizer.plan(const []), throwsArgumentError);
  });
}

WorkOrderRouteStop _stop({
  required String orderNumber,
  required String objectName,
  required double? latitude,
  required double? longitude,
  required DateTime start,
}) {
  final suffix = orderNumber.substring(orderNumber.length - 1);
  return WorkOrderRouteStop(
    workOrder: WorkOrder(
      id: 'order-$suffix',
      tenantId: 'tenant-1',
      orderNumber: orderNumber,
      title: 'Auftrag $suffix',
      type: 'inspection',
      status: WorkOrderStatus.scheduled,
      priority: WorkOrderPriority.normal,
      version: 1,
      syncStatus: 'synced',
      scheduledStart: start,
      scheduledEnd: start.add(const Duration(hours: 1)),
    ),
    object: CustomerObject(
      id: 'object-$suffix',
      tenantId: 'tenant-1',
      customerId: 'customer-1',
      name: objectName,
      street: 'Street',
      houseNumber: suffix,
      postalCode: '8000',
      city: 'City',
      country: 'CH',
      latitude: latitude,
      longitude: longitude,
    ),
  );
}
