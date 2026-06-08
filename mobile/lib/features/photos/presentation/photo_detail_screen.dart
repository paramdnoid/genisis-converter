import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/photo_providers.dart';

class PhotoDetailScreen extends ConsumerWidget {
  const PhotoDetailScreen({required this.photoId, super.key});

  final String photoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = ref.watch(photoDetailProvider(photoId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.photoTitle)),
      body: SafeArea(
        child: photo.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.photoLoadErrorTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(photoDetailProvider(photoId)),
          ),
          data: (photo) {
            if (photo == null) {
              return EmptyState(
                icon: Icons.broken_image_outlined,
                title: context.l10n.photoNotFoundTitle,
                message: context.l10n.photoMetadataMissingMessage,
              );
            }
            return _PhotoDetailContent(photo: photo);
          },
        ),
      ),
    );
  }
}

class _PhotoDetailContent extends ConsumerStatefulWidget {
  const _PhotoDetailContent({required this.photo});

  final PhotoAttachment photo;

  @override
  ConsumerState<_PhotoDetailContent> createState() =>
      _PhotoDetailContentState();
}

class _PhotoDetailContentState extends ConsumerState<_PhotoDetailContent> {
  late final TextEditingController _captionController;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: widget.photo.caption);
  }

  @override
  void didUpdateWidget(covariant _PhotoDetailContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photo.id != widget.photo.id ||
        oldWidget.photo.caption != widget.photo.caption) {
      _captionController.text = widget.photo.caption ?? '';
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;
    final file = File(photo.localPath);
    final exists = file.existsSync();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: exists
                ? Image.file(file, fit: BoxFit.contain)
                : ColoredBox(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _captionController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: context.l10n.photoCaptionLabel,
                    prefixIcon: const Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
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
                    if (photo.defectId != null)
                      StatusBadge(
                        label: context.l10n.defectAssignedStatus,
                        icon: Icons.report_problem_outlined,
                        tone: StatusBadgeTone.warning,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: _saveCaption,
                  icon: const Icon(Icons.save_outlined),
                  label: Text(context.l10n.savePhotoCaptionAction),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${photo.fileName} · ${context.formatDecimal(photo.sizeBytes / 1024, decimalDigits: 0)} KB',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Future<void> _saveCaption() async {
    final update = await ref.read(updatePhotoCaptionProvider.future);
    final caption = _captionController.text.trim();
    await update(
      id: widget.photo.id,
      caption: caption.isEmpty ? null : caption,
    );
    ref.invalidate(photoDetailProvider(widget.photo.id));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.photoCaptionSavedMessage)),
      );
    }
  }
}
