import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../../domain/entities/work_order.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/installation_providers.dart';

class InstallationDetailScreen extends ConsumerWidget {
  const InstallationDetailScreen({required this.installationId, super.key});

  final String installationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(installationDetailProvider(installationId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.installationTitle)),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 5),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.installationLoadErrorTitle,
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(installationDetailProvider(installationId)),
          ),
          data: (detail) {
            if (detail == null) {
              return EmptyState(
                icon: Icons.fireplace_outlined,
                title: context.l10n.installationNotFoundTitle,
                message: context.l10n.localRecordMissingMessage,
              );
            }
            final installation = detail.installation;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _InstallationHeader(installation: installation),
                const SizedBox(height: AppSpacing.md),
                _InstallationNotesCard(
                  installationId: installation.id,
                  initialNotes: installation.notes,
                ),
                const SizedBox(height: AppSpacing.lg),
                _PhotoList(photos: detail.photos),
                const SizedBox(height: AppSpacing.lg),
                _HistoryList(history: detail.history),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InstallationHeader extends StatelessWidget {
  const _InstallationHeader({required this.installation});

  final Installation installation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _installationTitle(installation),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('${context.l10n.typeLabel}: ${installation.type}'),
            Text(
              '${context.l10n.fuelTypeLabel}: ${installation.fuelType ?? '-'}',
            ),
            Text(
              '${context.l10n.locationLabel}: ${installation.locationDescription ?? '-'}',
            ),
            Text(
              '${context.l10n.serialNumberLabel}: ${installation.serialNumber ?? '-'}',
            ),
            Text(
              '${context.l10n.lastServiceLabel}: ${_formatDate(context, installation.lastServiceDate)}',
            ),
            Text(
              '${context.l10n.nextServiceLabel}: ${_formatDate(context, installation.nextServiceDate)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _InstallationNotesCard extends ConsumerStatefulWidget {
  const _InstallationNotesCard({
    required this.installationId,
    required this.initialNotes,
  });

  final String installationId;
  final String? initialNotes;

  @override
  ConsumerState<_InstallationNotesCard> createState() =>
      _InstallationNotesCardState();
}

class _InstallationNotesCardState
    extends ConsumerState<_InstallationNotesCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void didUpdateWidget(covariant _InstallationNotesCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialNotes != widget.initialNotes) {
      _controller.text = widget.initialNotes ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.installationNotesTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: context.l10n.installationNotesLabel,
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(context.l10n.saveNotesAction),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final repository = await ref.read(installationRepositoryProvider.future);
    final notes = _controller.text.trim();
    await repository.updateNotes(
      id: widget.installationId,
      notes: notes.isEmpty ? null : notes,
    );
    ref.invalidate(installationDetailProvider(widget.installationId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.installationNotesSavedMessage)),
      );
    }
  }
}

class _PhotoList extends StatelessWidget {
  const _PhotoList({required this.photos});

  final List<PhotoAttachment> photos;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.installationPhotosTitle,
      emptyIcon: Icons.photo_camera_outlined,
      emptyTitle: context.l10n.installationPhotosEmptyTitle,
      children: photos
          .map(
            (photo) => ListTile(
              leading: _PhotoThumb(photo: photo),
              title: Text(photo.caption ?? photo.fileName),
              subtitle: Text(
                '${context.formatDecimal(photo.sizeBytes / 1024, decimalDigits: 0)} KB',
              ),
              onTap: photo.workOrderId == null
                  ? null
                  : () => context.push(
                      AppRoutes.workOrderPhotoDetailPath(
                        photo.workOrderId!,
                        photo.id,
                      ),
                    ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.history});

  final List<WorkOrder> history;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.installationHistoryTitle,
      emptyIcon: Icons.history_outlined,
      emptyTitle: context.l10n.ordersEmptyTitle,
      children: history
          .map(
            (order) => ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(order.title),
              subtitle: Text(
                '${order.orderNumber} · ${_formatDate(context, order.scheduledStart)}',
              ),
              trailing: Text(order.status.label),
              onTap: () =>
                  context.push(AppRoutes.workOrderDetailPath(order.id)),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.photo});

  final PhotoAttachment photo;

  @override
  Widget build(BuildContext context) {
    final file = File(photo.localPath);
    if (!file.existsSync()) {
      return const Icon(Icons.broken_image_outlined);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.file(file, width: 48, height: 48, fit: BoxFit.cover),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.children,
  });

  final String title;
  final IconData emptyIcon;
  final String emptyTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            if (children.isEmpty)
              EmptyState(icon: emptyIcon, title: emptyTitle, message: '')
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

String _installationTitle(Installation installation) {
  return installation.displayName;
}

String _formatDate(BuildContext context, DateTime? value) {
  if (value == null) {
    return context.l10n.noDate;
  }
  return context.formatShortDate(value);
}
