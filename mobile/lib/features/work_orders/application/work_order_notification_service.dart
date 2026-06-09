import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/sync/work_order_notification_sink.dart';

final class LocalWorkOrderNotificationService
    implements WorkOrderNotificationSink {
  LocalWorkOrderNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _channelId = 'new_work_orders';
  static const _channelName = 'Neue Aufträge';
  static const _channelDescription =
      'Benachrichtigungen für neu synchronisierte Aufträge.';

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  @override
  Future<void> notifyNewWorkOrder(NewWorkOrderNotification notification) async {
    if (notification.workOrderId.trim().isEmpty) {
      return;
    }

    await _ensureInitialized();
    await _plugin.show(
      id: _stableNotificationId(notification.workOrderId),
      title: 'Neuer Auftrag ${notification.orderNumber}',
      body: _notificationBody(notification),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      ),
      payload: notification.workOrderId,
    );
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) {
      return;
    }

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
        macOS: DarwinInitializationSettings(),
      ),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    _initialized = true;
  }
}

String _notificationBody(NewWorkOrderNotification notification) {
  final title = notification.title.trim().isEmpty
      ? notification.orderNumber
      : notification.title;
  final scheduledStart = notification.scheduledStart;
  if (scheduledStart == null) {
    return title;
  }
  return '$title · ${_formatDateTime(scheduledStart)}';
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$day.$month.${local.year} $hour:$minute';
}

int _stableNotificationId(String value) {
  var hash = 0;
  for (final codeUnit in value.codeUnits) {
    hash = (hash * 31 + codeUnit) & 0x3fffffff;
  }
  return hash == 0 ? 1 : hash;
}
