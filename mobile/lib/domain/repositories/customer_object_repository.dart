import '../entities/customer_object.dart';
import '../entities/customer_object_detail.dart';

abstract interface class CustomerObjectRepository {
  Stream<List<CustomerObject>> watchAll();

  Future<CustomerObject?> getById(String id);

  Future<CustomerObjectDetail?> getDetail(String id);

  Future<void> updateNotes({required String id, String? notes});
}
