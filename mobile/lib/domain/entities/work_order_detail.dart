import 'customer.dart';
import 'customer_object.dart';
import 'installation.dart';
import 'work_order.dart';
import 'work_order_service.dart';

final class WorkOrderDetail {
  const WorkOrderDetail({
    required this.workOrder,
    required this.customer,
    required this.object,
    required this.installations,
    this.availableTariffs = const [],
    this.serviceLines = const [],
  });

  final WorkOrder workOrder;
  final Customer customer;
  final CustomerObject object;
  final List<Installation> installations;
  final List<ObjectTariffAssignment> availableTariffs;
  final List<WorkOrderServiceLine> serviceLines;

  String get primaryPhone => customer.preferredPhone ?? '';
  bool get hasPhone => primaryPhone.trim().isNotEmpty;
}
