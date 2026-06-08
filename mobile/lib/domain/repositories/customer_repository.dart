import '../entities/customer.dart';
import '../entities/customer_detail.dart';

abstract interface class CustomerRepository {
  Stream<List<Customer>> watchAll();

  Future<Customer?> getById(String id);

  Future<CustomerDetail?> getDetail(String id);

  Future<void> updateNotes({required String id, String? notes});
}
