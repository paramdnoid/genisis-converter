import '../../domain/entities/customer_object.dart';
import '../../domain/entities/customer_object_detail.dart';
import '../../domain/repositories/customer_object_repository.dart';
import '../db/app_database.dart';
import 'drift_entity_mappers.dart';

final class DriftCustomerObjectRepository implements CustomerObjectRepository {
  const DriftCustomerObjectRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<CustomerObject>> watchAll() {
    return database.objectDao
        .watchActive(tenantId)
        .map((rows) => rows.map(mapCustomerObjectRow).toList(growable: false));
  }

  @override
  Future<CustomerObject?> getById(String id) async {
    final row = await database.objectDao.getById(id);
    if (row == null || row.tenantId != tenantId || row.deletedAt != null) {
      return null;
    }

    return mapCustomerObjectRow(row);
  }

  @override
  Future<CustomerObjectDetail?> getDetail(String id) async {
    final object = await getById(id);
    if (object == null) {
      return null;
    }

    final installations = await database.installationDao
        .watchForObject(tenantId, id)
        .first;
    final history = await database.workOrderDao
        .watchForObject(tenantId, id)
        .first;

    return CustomerObjectDetail(
      object: object,
      installations: installations
          .map(mapInstallationRow)
          .toList(growable: false),
      history: history.map(mapWorkOrderRow).toList(growable: false),
    );
  }

  @override
  Future<void> updateNotes({required String id, String? notes}) {
    return database.objectDao.updateNotesLocal(id: id, notes: notes);
  }
}
