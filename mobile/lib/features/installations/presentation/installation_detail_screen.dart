import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../../domain/entities/photo_attachment.dart';
import '../../work_orders/application/work_order_providers.dart';

final installationDetailProvider = FutureProvider.autoDispose
    .family<InstallationDetailData?, String>((ref, installationId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final installation = await database.installationDao.getById(
        installationId,
      );
      if (installation == null || installation.deletedAt != null) {
        return null;
      }
      final history = await database.workOrderDao
          .watchForInstallation(tenantId, installationId)
          .first;
      final photos = await database.photoDao
          .watchForInstallation(tenantId, installationId)
          .first;
      return InstallationDetailData(
        installation: installation,
        history: history,
        photos: photos
            .map(
              (row) => PhotoAttachment(
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
              ),
            )
            .toList(growable: false),
      );
    });

final class InstallationDetailData {
  const InstallationDetailData({
    required this.installation,
    required this.history,
    required this.photos,
  });

  final InstallationRow installation;
  final List<WorkOrderRow> history;
  final List<PhotoAttachment> photos;
}

class InstallationDetailScreen extends ConsumerWidget {
  const InstallationDetailScreen({required this.installationId, super.key});

  final String installationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(installationDetailProvider(installationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Anlage')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 5),
          error: (error, stackTrace) => ErrorState(
            title: 'Anlage konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(installationDetailProvider(installationId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.fireplace_outlined,
                title: 'Anlage nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
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

  final InstallationRow installation;

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
            Text('Typ: ${installation.type}'),
            Text('Brennstoff: ${installation.fuelType ?? '-'}'),
            Text('Standort: ${installation.locationDescription ?? '-'}'),
            Text('Seriennummer: ${installation.serialNumber ?? '-'}'),
            Text('Letzte Arbeit: ${_formatDate(installation.lastServiceDate)}'),
            Text(
              'Nächste Arbeit: ${_formatDate(installation.nextServiceDate)}',
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
              'Anlagennotizen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Notizen zur Anlage',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Notizen speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final database = await ref.read(databaseReadyProvider.future);
    final notes = _controller.text.trim();
    await database.installationDao.updateNotesLocal(
      id: widget.installationId,
      notes: notes.isEmpty ? null : notes,
    );
    ref.invalidate(installationDetailProvider(widget.installationId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anlagennotizen lokal gespeichert.')),
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
      title: 'Fotos zur Anlage',
      emptyIcon: Icons.photo_camera_outlined,
      emptyTitle: 'Keine Anlagenfotos',
      children: photos
          .map(
            (photo) => ListTile(
              leading: _PhotoThumb(photo: photo),
              title: Text(photo.caption ?? photo.fileName),
              subtitle: Text(
                '${(photo.sizeBytes / 1024).toStringAsFixed(0)} KB',
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

  final List<WorkOrderRow> history;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Anlagenhistorie',
      emptyIcon: Icons.history_outlined,
      emptyTitle: 'Keine Aufträge',
      children: history
          .map(
            (order) => ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(order.title),
              subtitle: Text(
                '${order.orderNumber} · ${_formatDate(order.scheduledStart)}',
              ),
              trailing: Text(order.status),
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

String _installationTitle(InstallationRow installation) {
  final title = [
    installation.manufacturer,
    installation.model,
  ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');
  return title.isEmpty ? installation.type : title;
}

String _formatDate(String? value) {
  final date = value == null ? null : DateTime.tryParse(value)?.toLocal();
  if (date == null) {
    return 'ohne Datum';
  }
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}
