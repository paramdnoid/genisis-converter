import '../../domain/entities/photo_attachment.dart';
import '../../domain/repositories/photo_repository.dart';
import '../db/app_database.dart';
import 'drift_entity_mappers.dart';

final class DriftPhotoRepository implements PhotoRepository {
  const DriftPhotoRepository({required this.database, required this.tenantId});

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<PhotoAttachment>> watchForWorkOrder(String workOrderId) {
    return database.photoDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(mapPhotoRow).toList(growable: false));
  }

  @override
  Stream<List<PhotoAttachment>> watchForDefect(String defectId) {
    return database.photoDao
        .watchForDefect(tenantId, defectId)
        .map((rows) => rows.map(mapPhotoRow).toList(growable: false));
  }

  @override
  Stream<List<PhotoAttachment>> watchForInstallation(String installationId) {
    return database.photoDao
        .watchForInstallation(tenantId, installationId)
        .map((rows) => rows.map(mapPhotoRow).toList(growable: false));
  }

  @override
  Future<PhotoAttachment?> getById(String id) async {
    final row = await database.photoDao.getById(id);
    return row == null ? null : mapPhotoRow(row);
  }

  @override
  Future<String> create(PhotoDraft draft) {
    return database.photoDao.createLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      objectId: draft.objectId,
      installationId: draft.installationId,
      defectId: draft.defectId,
      localPath: draft.localPath,
      fileName: draft.fileName,
      mimeType: draft.mimeType,
      sizeBytes: draft.sizeBytes,
      caption: draft.caption,
    );
  }

  @override
  Future<void> updateCaption({required String id, required String? caption}) {
    return database.photoDao.updateCaptionLocal(id: id, caption: caption);
  }

  @override
  Future<void> attachToDefect({required String id, required String? defectId}) {
    return database.photoDao.attachToDefectLocal(id: id, defectId: defectId);
  }
}
