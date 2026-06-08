import '../../domain/entities/installation.dart';
import '../../domain/entities/installation_detail.dart';
import '../../domain/repositories/installation_repository.dart';
import '../db/app_database.dart';
import 'drift_entity_mappers.dart';

final class DriftInstallationRepository implements InstallationRepository {
  const DriftInstallationRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<Installation>> watchAll() {
    return database.installationDao
        .watchActive(tenantId)
        .map((rows) => rows.map(mapInstallationRow).toList(growable: false));
  }

  @override
  Future<Installation?> getById(String id) async {
    final row = await database.installationDao.getById(id);
    if (row == null || row.tenantId != tenantId || row.deletedAt != null) {
      return null;
    }

    return mapInstallationRow(row);
  }

  @override
  Future<InstallationDetail?> getDetail(String id) async {
    final installation = await getById(id);
    if (installation == null) {
      return null;
    }

    final history = await database.workOrderDao
        .watchForInstallation(tenantId, id)
        .first;
    final photos = await database.photoDao
        .watchForInstallation(tenantId, id)
        .first;

    return InstallationDetail(
      installation: installation,
      history: history.map(mapWorkOrderRow).toList(growable: false),
      photos: photos.map(mapPhotoRow).toList(growable: false),
    );
  }

  @override
  Future<void> updateNotes({required String id, String? notes}) {
    return database.installationDao.updateNotesLocal(id: id, notes: notes);
  }
}
