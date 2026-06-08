import 'customer.dart';
import 'customer_object.dart';
import 'work_order.dart';

final class CustomerDetail {
  const CustomerDetail({
    required this.customer,
    required this.objects,
    required this.history,
  });

  final Customer customer;
  final List<CustomerObject> objects;
  final List<WorkOrder> history;
}
