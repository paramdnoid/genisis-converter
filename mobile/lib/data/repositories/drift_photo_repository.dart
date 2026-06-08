import '../../domain/entities/photo_attachment.dart';
import '../../domain/repositories/photo_repository.dart';
import '../db/app_database.dart';

final class DriftPhotoRepository implements PhotoRepository {
  const DriftPhotoRepository({required this.database, required this.tenantId});

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<PhotoAttachment>> watchForWorkOrder(String workOrderId) {
    return database.photoDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Stream<List<PhotoAttachment>> watchForDefect(String defectId) {
    return database.photoDao
        .watchForDefect(tenantId, defectId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Stream<List<PhotoAttachment>> watchForInstallation(String installationId) {
    return database.photoDao
        .watchForInstallation(tenantId, installationId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<PhotoAttachment?> getById(String id) async {
    final row = await database.photoDao.getById(id);
    return row == null ? null : _mapRow(row);
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

PhotoAttachment _mapRow(PhotoRow row) {
  return PhotoAttachment(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    objectId: row.objectId,
    installationId: row.installationId,
    defectId: row.defectId,
    localPath: row.localPath,
    remoteUrl: row.remoteUrl,
    fileName: row.fileName,
    mimeType: row.mimeType,
    sizeBytes: row.sizeBytes,
    caption: row.caption,
    takenAt: DateTime.parse(row.takenAt),
    uploadStatus: row.uploadStatus,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
