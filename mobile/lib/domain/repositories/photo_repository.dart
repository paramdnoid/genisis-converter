import '../entities/photo_attachment.dart';

abstract interface class PhotoRepository {
  Stream<List<PhotoAttachment>> watchForWorkOrder(String workOrderId);
  Future<String> create(PhotoDraft draft);
  Future<void> updateCaption({required String id, required String? caption});
}
