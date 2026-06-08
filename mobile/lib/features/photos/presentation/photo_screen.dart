import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/files/file_storage_service.dart';
import '../../../core/permissions/permission_service.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../../l10n/app_localizations_x.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/photo_providers.dart';

class PhotoScreen extends ConsumerWidget {
  const PhotoScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photosForWorkOrderProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.photosTitle)),
      body: SafeArea(
        child: photos.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.photosLoadErrorTitle,
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(photosForWorkOrderProvider(workOrderId)),
          ),
          data: (photos) =>
              _PhotoContent(workOrderId: workOrderId, photos: photos),
        ),
      ),
    );
  }
}

class _PhotoContent extends ConsumerWidget {
  const _PhotoContent({required this.workOrderId, required this.photos});

  final String workOrderId;
  final List<PhotoAttachment> photos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        _PhotoActions(workOrderId: workOrderId),
        const SizedBox(height: AppSpacing.lg),
        if (photos.isEmpty)
          EmptyState(
            icon: Icons.photo_camera_outlined,
            title: context.l10n.photosEmptyTitle,
            message: context.l10n.photosEmptyMessage,
          )
        else
          ...photos.map(
            (photo) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _PhotoCard(photo: photo),
            ),
          ),
      ],
    );
  }
}

class _PhotoActions extends ConsumerWidget {
  const _PhotoActions({required this.workOrderId});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.photoAddTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _pick(context, ref, ImageSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: Text(context.l10n.cameraAction),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pick(context, ref, ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text(context.l10n.galleryAction),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
  ) async {
    try {
      if (source == ImageSource.camera) {
        await const PermissionService().require(AppPermission.camera);
      } else {
        await const PermissionService().require(AppPermission.photos);
      }

      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 78,
      );
      if (picked == null) {
        return;
      }

      final tenantId = ref.read(activeTenantIdProvider);
      final fileName = '${const Uuid().v4()}.jpg';
      final stored = await const FileStorageService().copyIntoWorkOrder(
        tenantId: tenantId,
        workOrderId: workOrderId,
        source: File(picked.path),
        fileName: fileName,
        mimeType: 'image/jpeg',
      );
      final create = await ref.read(createPhotoProvider.future);
      await create(
        PhotoDraft(
          workOrderId: workOrderId,
          localPath: stored.path,
          fileName: stored.fileName,
          mimeType: stored.mimeType,
          sizeBytes: stored.sizeBytes,
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.photoSavedMessage)));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({required this.photo});

  final PhotoAttachment photo;

  @override
  Widget build(BuildContext context) {
    final exists = File(photo.localPath).existsSync();

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: photo.workOrderId == null
            ? null
            : () => context.push(
                AppRoutes.workOrderPhotoDetailPath(
                  photo.workOrderId!,
                  photo.id,
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox.square(
                  dimension: 88,
                  child: exists
                      ? Image.file(File(photo.localPath), fit: BoxFit.cover)
                      : ColoredBox(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: const Icon(Icons.broken_image_outlined),
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo.caption ?? photo.fileName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${context.formatDecimal(photo.sizeBytes / 1024, decimalDigits: 0)} KB',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    StatusBadge(
                      label: photo.isPendingUpload
                          ? context.l10n.uploadPendingStatus
                          : context.l10n.uploadedStatus,
                      icon: photo.isPendingUpload
                          ? Icons.cloud_upload_outlined
                          : Icons.cloud_done_outlined,
                      tone: photo.isPendingUpload
                          ? StatusBadgeTone.warning
                          : StatusBadgeTone.success,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
