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

final createPhotoProvider = FutureProvider<CreatePhoto>((ref) async {
  final repository = await ref.watch(photoRepositoryProvider.future);
  return CreatePhoto(repository);
});

final class CreatePhoto {
  const CreatePhoto(this._repository);

  final PhotoRepository _repository;

  Future<String> call(PhotoDraft draft) {
    return _repository.create(draft);
  }
}
