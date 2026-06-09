import 'customer.dart';
import 'customer_object.dart';
import 'installation.dart';

final class RecurringWorkOrderCandidate {
  const RecurringWorkOrderCandidate({
    required this.installation,
    required this.object,
    required this.customer,
  });

  final Installation installation;
  final CustomerObject object;
  final Customer customer;

  DateTime get dueDate => installation.nextServiceDate!;

  int get intervalMonths => installation.intervalMonths!;
}
