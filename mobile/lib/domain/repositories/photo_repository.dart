import '../entities/photo_attachment.dart';

abstract interface class PhotoRepository {
  Stream<List<PhotoAttachment>> watchForWorkOrder(String workOrderId);
  Stream<List<PhotoAttachment>> watchForDefect(String defectId);
  Stream<List<PhotoAttachment>> watchForInstallation(String installationId);
  Future<PhotoAttachment?> getById(String id);
  Future<String> create(PhotoDraft draft);
  Future<void> updateCaption({required String id, required String? caption});
  Future<void> attachToDefect({required String id, required String? defectId});
}
