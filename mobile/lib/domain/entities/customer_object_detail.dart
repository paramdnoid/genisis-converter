import 'customer_object.dart';
import 'installation.dart';
import 'work_order.dart';

final class CustomerObjectDetail {
  const CustomerObjectDetail({
    required this.object,
    required this.installations,
    required this.history,
  });

  final CustomerObject object;
  final List<Installation> installations;
  final List<WorkOrder> history;
}
