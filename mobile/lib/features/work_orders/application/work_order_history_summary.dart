import '../../../domain/entities/work_order.dart';
import '../../../domain/enums/work_order_status.dart';

final class WorkOrderHistorySummary {
  WorkOrderHistorySummary._({
    required this.orders,
    required this.groups,
    required this.totalCount,
    required this.completedCount,
    required this.openCount,
    required this.overdueCount,
    required this.localChangeCount,
    required this.lastCompleted,
    required this.nextScheduled,
  });

  factory WorkOrderHistorySummary.from(
    List<WorkOrder> history, {
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final today = DateTime(reference.year, reference.month, reference.day);
    final sorted = history.toList(growable: false)
      ..sort(_compareOrdersByHistoryDateDesc);

    final completed =
        sorted
            .where((order) => _isCompletedStatus(order.status))
            .toList(growable: false)
          ..sort(_compareOrdersByCompletionDateDesc);
    final upcoming =
        sorted
            .where(
              (order) =>
                  !_isClosedStatus(order.status) &&
                  order.scheduledStart != null &&
                  !order.scheduledStart!.isBefore(reference),
            )
            .toList(growable: false)
          ..sort(_compareOrdersByScheduledDateAsc);

    return WorkOrderHistorySummary._(
      orders: List.unmodifiable(sorted),
      groups: List.unmodifiable(_buildGroups(sorted)),
      totalCount: sorted.length,
      completedCount: completed.length,
      openCount: sorted.where((order) => !_isClosedStatus(order.status)).length,
      overdueCount: sorted.where((order) {
        final scheduled = order.scheduledStart;
        return !_isClosedStatus(order.status) &&
            scheduled != null &&
            scheduled.isBefore(today);
      }).length,
      localChangeCount: sorted.where((order) => order.isDirty).length,
      lastCompleted: _firstOrNull(completed),
      nextScheduled: _firstOrNull(upcoming),
    );
  }

  final List<WorkOrder> orders;
  final List<WorkOrderHistoryGroup> groups;
  final int totalCount;
  final int completedCount;
  final int openCount;
  final int overdueCount;
  final int localChangeCount;
  final WorkOrder? lastCompleted;
  final WorkOrder? nextScheduled;
}

final class WorkOrderHistoryGroup {
  const WorkOrderHistoryGroup({required this.month, required this.orders});

  final DateTime? month;
  final List<WorkOrder> orders;
}

List<WorkOrderHistoryGroup> _buildGroups(List<WorkOrder> orders) {
  final groups = <String, _WorkOrderHistoryGroupBuilder>{};
  for (final order in orders) {
    final date = _historyDate(order);
    final month = date == null ? null : DateTime(date.year, date.month);
    final key = month == null ? 'undated' : '${month.year}-${month.month}';
    final group = groups.putIfAbsent(
      key,
      () => _WorkOrderHistoryGroupBuilder(month),
    );
    group.orders.add(order);
  }

  return groups.values
      .map(
        (group) => WorkOrderHistoryGroup(
          month: group.month,
          orders: List.unmodifiable(group.orders),
        ),
      )
      .toList(growable: false);
}

int _compareOrdersByHistoryDateDesc(WorkOrder left, WorkOrder right) {
  final dateCompare = _compareNullableDateDesc(
    _historyDate(left),
    _historyDate(right),
  );
  if (dateCompare != 0) {
    return dateCompare;
  }
  return left.orderNumber.compareTo(right.orderNumber);
}

int _compareOrdersByCompletionDateDesc(WorkOrder left, WorkOrder right) {
  final dateCompare = _compareNullableDateDesc(
    _completionDate(left),
    _completionDate(right),
  );
  if (dateCompare != 0) {
    return dateCompare;
  }
  return left.orderNumber.compareTo(right.orderNumber);
}

int _compareOrdersByScheduledDateAsc(WorkOrder left, WorkOrder right) {
  final dateCompare = _compareNullableDateAsc(
    left.scheduledStart,
    right.scheduledStart,
  );
  if (dateCompare != 0) {
    return dateCompare;
  }
  return left.orderNumber.compareTo(right.orderNumber);
}

int _compareNullableDateDesc(DateTime? left, DateTime? right) {
  if (left == null && right == null) {
    return 0;
  }
  if (left == null) {
    return 1;
  }
  if (right == null) {
    return -1;
  }
  return right.compareTo(left);
}

int _compareNullableDateAsc(DateTime? left, DateTime? right) {
  if (left == null && right == null) {
    return 0;
  }
  if (left == null) {
    return 1;
  }
  if (right == null) {
    return -1;
  }
  return left.compareTo(right);
}

DateTime? _historyDate(WorkOrder order) {
  return order.scheduledStart ?? order.actualEnd ?? order.actualStart;
}

DateTime? _completionDate(WorkOrder order) {
  return order.actualEnd ?? order.scheduledEnd ?? order.scheduledStart;
}

bool _isClosedStatus(WorkOrderStatus status) {
  return _isCompletedStatus(status) || status == WorkOrderStatus.cancelled;
}

bool _isCompletedStatus(WorkOrderStatus status) {
  return status == WorkOrderStatus.completed ||
      status == WorkOrderStatus.synced;
}

WorkOrder? _firstOrNull(List<WorkOrder> orders) {
  return orders.isEmpty ? null : orders.first;
}

final class _WorkOrderHistoryGroupBuilder {
  _WorkOrderHistoryGroupBuilder(this.month);

  final DateTime? month;
  final List<WorkOrder> orders = [];
}
