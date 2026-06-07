import 'customer.dart';
import 'customer_object.dart';
import 'installation.dart';
import 'work_order.dart';

final class WorkOrderDetail {
  const WorkOrderDetail({
    required this.workOrder,
    required this.customer,
    required this.object,
    required this.installations,
  });

  final WorkOrder workOrder;
  final Customer customer;
  final CustomerObject object;
  final List<Installation> installations;

  String get primaryPhone => customer.preferredPhone ?? '';
  bool get hasPhone => primaryPhone.trim().isNotEmpty;
}
