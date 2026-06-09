import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/work_order_history_summary.dart';

void main() {
  test('summarizes local work order history by status and schedule', () {
    final now = DateTime(2026, 6, 8, 12);

    final summary = WorkOrderHistorySummary.from([
      _order(
        id: 'completed',
        orderNumber: 'WO-2026-0001',
        status: WorkOrderStatus.completed,
        scheduledStart: DateTime(2026, 5, 2, 8),
        scheduledEnd: DateTime(2026, 5, 2, 10),
        actualEnd: DateTime(2026, 5, 2, 9, 45),
      ),
      _order(
        id: 'future',
        orderNumber: 'WO-2026-0002',
        status: WorkOrderStatus.scheduled,
        scheduledStart: DateTime(2026, 6, 9, 8),
        syncStatus: 'pending',
      ),
      _order(
        id: 'overdue',
        orderNumber: 'WO-2026-0003',
        status: WorkOrderStatus.inProgress,
        scheduledStart: DateTime(2026, 6, 7, 8),
      ),
      _order(
        id: 'cancelled',
        orderNumber: 'WO-2026-0004',
        status: WorkOrderStatus.cancelled,
        scheduledStart: DateTime(2026, 4, 1, 8),
      ),
    ], now: now);

    expect(summary.totalCount, 4);
    expect(summary.completedCount, 1);
    expect(summary.openCount, 2);
    expect(summary.overdueCount, 1);
    expect(summary.localChangeCount, 1);
    expect(summary.lastCompleted?.id, 'completed');
    expect(summary.nextScheduled?.id, 'future');
    expect(summary.orders.map((order) => order.id), [
      'future',
      'overdue',
      'completed',
      'cancelled',
    ]);
    expect(summary.groups.map((group) => group.month), [
      DateTime(2026, 6),
      DateTime(2026, 5),
      DateTime(2026, 4),
    ]);
  });

  test('keeps undated work orders at the end of the timeline', () {
    final summary = WorkOrderHistorySummary.from([
      _order(
        id: 'without-date',
        orderNumber: 'WO-2026-0002',
        status: WorkOrderStatus.draft,
      ),
      _order(
        id: 'with-date',
        orderNumber: 'WO-2026-0001',
        status: WorkOrderStatus.scheduled,
        scheduledStart: DateTime(2026, 6, 9, 8),
      ),
    ], now: DateTime(2026, 6, 8, 12));

    expect(summary.orders.map((order) => order.id), [
      'with-date',
      'without-date',
    ]);
    expect(summary.groups.first.month, DateTime(2026, 6));
    expect(summary.groups.last.month, isNull);
  });
}

WorkOrder _order({
  required String id,
  required String orderNumber,
  required WorkOrderStatus status,
  DateTime? scheduledStart,
  DateTime? scheduledEnd,
  DateTime? actualEnd,
  String syncStatus = 'synced',
}) {
  return WorkOrder(
    id: id,
    tenantId: 'tenant-1',
    orderNumber: orderNumber,
    title: 'Auftrag $orderNumber',
    type: 'service',
    status: status,
    priority: WorkOrderPriority.normal,
    version: 1,
    syncStatus: syncStatus,
    customerId: 'customer-1',
    objectId: 'object-1',
    scheduledStart: scheduledStart,
    scheduledEnd: scheduledEnd,
    actualEnd: actualEnd,
  );
}
