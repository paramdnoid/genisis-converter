import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/customer_object.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order_route_stop.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/offline_route_map.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/work_order_route_optimizer.dart';

void main() {
  test('normalizes optimized route stops into offline map points', () {
    final route = OptimizedWorkOrderRoute(
      stops: [
        _stop(
          orderNumber: 'WO-1',
          latitude: 47.0,
          longitude: 8.0,
          scheduledStart: DateTime.utc(2026, 1, 1, 8),
        ),
        _stop(
          orderNumber: 'WO-2',
          latitude: 47.5,
          longitude: 8.5,
          scheduledStart: DateTime.utc(2026, 1, 1, 9),
        ),
      ],
      mapsUri: Uri.parse('https://example.invalid'),
      optimizedByCoordinates: true,
    );

    final map = const OfflineRouteMapBuilder().build(route);

    expect(map.points, hasLength(2));
    expect(map.unmappedStops, isEmpty);
    expect(map.hasPolyline, isTrue);
    expect(map.points.first.sequence, 1);
    expect(map.points.first.x, 0);
    expect(map.points.first.y, 1);
    expect(map.points.last.x, 1);
    expect(map.points.last.y, 0);
  });

  test('keeps route stops without coordinates out of the offline map', () {
    final mapped = _stop(orderNumber: 'WO-1', latitude: 47.0, longitude: 8.0);
    final unmapped = _stop(orderNumber: 'WO-2');
    final route = OptimizedWorkOrderRoute(
      stops: [mapped, unmapped],
      mapsUri: Uri.parse('https://example.invalid'),
      optimizedByCoordinates: false,
    );

    final map = const OfflineRouteMapBuilder().build(route);

    expect(map.points, hasLength(1));
    expect(map.unmappedStops.single.workOrder.orderNumber, 'WO-2');
    expect(map.hasPolyline, isFalse);
    expect(map.bounds.minLatitude, lessThan(map.bounds.maxLatitude));
    expect(map.bounds.minLongitude, lessThan(map.bounds.maxLongitude));
  });

  test('rejects offline maps without any coordinates', () {
    final route = OptimizedWorkOrderRoute(
      stops: [_stop(orderNumber: 'WO-1')],
      mapsUri: Uri.parse('https://example.invalid'),
      optimizedByCoordinates: false,
    );

    expect(() => const OfflineRouteMapBuilder().build(route), throwsStateError);
  });
}

WorkOrderRouteStop _stop({
  required String orderNumber,
  double? latitude,
  double? longitude,
  DateTime? scheduledStart,
}) {
  return WorkOrderRouteStop(
    workOrder: WorkOrder(
      id: orderNumber,
      tenantId: 'tenant-1',
      orderNumber: orderNumber,
      title: 'Order $orderNumber',
      type: 'inspection',
      status: WorkOrderStatus.scheduled,
      priority: WorkOrderPriority.normal,
      version: 1,
      syncStatus: 'synced',
      scheduledStart: scheduledStart,
    ),
    object: CustomerObject(
      id: 'object-$orderNumber',
      tenantId: 'tenant-1',
      customerId: 'customer-1',
      name: 'Object $orderNumber',
      street: 'Street',
      houseNumber: '1',
      postalCode: '8000',
      city: 'City',
      country: 'CH',
      latitude: latitude,
      longitude: longitude,
    ),
  );
}
