import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_photo_repository.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../../domain/repositories/photo_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final photoRepositoryProvider = FutureProvider<PhotoRepository>((ref) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftPhotoRepository(database: database, tenantId: tenantId);
});

final photosForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<PhotoAttachment>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(photoRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final photosForDefectProvider = StreamProvider.autoDispose
    .family<List<PhotoAttachment>, String>((ref, defectId) async* {
      final repository = await ref.watch(photoRepositoryProvider.future);
      yield* repository.watchForDefect(defectId);
    });

final photosForInstallationProvider = StreamProvider.autoDispose
    .family<List<PhotoAttachment>, String>((ref, installationId) async* {
      final repository = await ref.watch(photoRepositoryProvider.future);
      yield* repository.watchForInstallation(installationId);
    });

final photoDetailProvider = FutureProvider.autoDispose
    .family<PhotoAttachment?, String>((ref, photoId) async {
      final repository = await ref.watch(photoRepositoryProvider.future);
      return repository.getById(photoId);
    });

final createPhotoProvider = FutureProvider<CreatePhoto>((ref) async {
  final repository = await ref.watch(photoRepositoryProvider.future);
  return CreatePhoto(repository);
});

final updatePhotoCaptionProvider = FutureProvider<UpdatePhotoCaption>((
  ref,
) async {
  final repository = await ref.watch(photoRepositoryProvider.future);
  return UpdatePhotoCaption(repository);
});

final attachPhotoToDefectProvider = FutureProvider<AttachPhotoToDefect>((
  ref,
) async {
  final repository = await ref.watch(photoRepositoryProvider.future);
  return AttachPhotoToDefect(repository);
});

final class CreatePhoto {
  const CreatePhoto(this._repository);

  final PhotoRepository _repository;

  Future<String> call(PhotoDraft draft) {
    return _repository.create(draft);
  }
}

final class UpdatePhotoCaption {
  const UpdatePhotoCaption(this._repository);

  final PhotoRepository _repository;

  Future<void> call({required String id, required String? caption}) {
    return _repository.updateCaption(id: id, caption: caption);
  }
}

final class AttachPhotoToDefect {
  const AttachPhotoToDefect(this._repository);

  final PhotoRepository _repository;

  Future<void> call({required String id, required String? defectId}) {
    return _repository.attachToDefect(id: id, defectId: defectId);
  }
}
