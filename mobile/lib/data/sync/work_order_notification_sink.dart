abstract interface class WorkOrderNotificationSink {
  Future<void> notifyNewWorkOrder(NewWorkOrderNotification notification);
}

final class NewWorkOrderNotification {
  const NewWorkOrderNotification({
    required this.workOrderId,
    required this.orderNumber,
    required this.title,
    this.scheduledStart,
  });

  factory NewWorkOrderNotification.fromData(Map<String, Object?> data) {
    return NewWorkOrderNotification(
      workOrderId: data['id']?.toString() ?? '',
      orderNumber: data['orderNumber']?.toString() ?? '',
      title: data['title']?.toString() ?? '',
      scheduledStart: _parseDate(data['scheduledStart']),
    );
  }

  final String workOrderId;
  final String orderNumber;
  final String title;
  final DateTime? scheduledStart;
}

final class NoopWorkOrderNotificationSink implements WorkOrderNotificationSink {
  const NoopWorkOrderNotificationSink();

  @override
  Future<void> notifyNewWorkOrder(
    NewWorkOrderNotification notification,
  ) async {}
}

DateTime? _parseDate(Object? value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString());
}
