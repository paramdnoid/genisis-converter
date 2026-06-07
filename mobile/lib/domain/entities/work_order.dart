import '../enums/work_order_status.dart';

final class WorkOrder {
  const WorkOrder({
    required this.id,
    required this.tenantId,
    required this.orderNumber,
    required this.title,
    required this.type,
    required this.status,
    required this.priority,
    required this.version,
    required this.syncStatus,
    this.description,
    this.customerId,
    this.objectId,
    this.assignedUserId,
    this.scheduledStart,
    this.scheduledEnd,
    this.actualStart,
    this.actualEnd,
    this.completionNotes,
  });

  final String id;
  final String tenantId;
  final String orderNumber;
  final String title;
  final String type;
  final WorkOrderStatus status;
  final WorkOrderPriority priority;
  final int version;
  final String syncStatus;
  final String? description;
  final String? customerId;
  final String? objectId;
  final String? assignedUserId;
  final DateTime? scheduledStart;
  final DateTime? scheduledEnd;
  final DateTime? actualStart;
  final DateTime? actualEnd;
  final String? completionNotes;

  bool isScheduledOn(DateTime day) {
    final scheduled = scheduledStart?.toLocal();
    if (scheduled == null) {
      return false;
    }

    return scheduled.year == day.year &&
        scheduled.month == day.month &&
        scheduled.day == day.day;
  }

  bool get isDirty => syncStatus != 'synced';
}
