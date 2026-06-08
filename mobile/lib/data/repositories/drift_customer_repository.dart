import '../../domain/entities/customer.dart';
import '../../domain/entities/customer_detail.dart';
import '../../domain/repositories/customer_repository.dart';
import '../db/app_database.dart';
import 'drift_entity_mappers.dart';

final class DriftCustomerRepository implements CustomerRepository {
  const DriftCustomerRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<Customer>> watchAll() {
    return database.customerDao
        .watchActive(tenantId)
        .map((rows) => rows.map(mapCustomerRow).toList(growable: false));
  }

  @override
  Future<Customer?> getById(String id) async {
    final row = await database.customerDao.getById(id);
    if (row == null || row.tenantId != tenantId || row.deletedAt != null) {
      return null;
    }

    return mapCustomerRow(row);
  }

  @override
  Future<CustomerDetail?> getDetail(String id) async {
    final customer = await getById(id);
    if (customer == null) {
      return null;
    }

    final objects = await database.objectDao
        .watchForCustomer(tenantId, id)
        .first;
    final history = await database.workOrderDao
        .watchForCustomer(tenantId, id)
        .first;

    return CustomerDetail(
      customer: customer,
      objects: objects.map(mapCustomerObjectRow).toList(growable: false),
      history: history.map(mapWorkOrderRow).toList(growable: false),
    );
  }

  @override
  Future<void> updateNotes({required String id, String? notes}) {
    return database.customerDao.updateNotesLocal(id: id, notes: notes);
  }
}
