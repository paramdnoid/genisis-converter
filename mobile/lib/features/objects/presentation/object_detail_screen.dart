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
import '../../work_orders/application/work_order_providers.dart';

final objectDetailProvider = FutureProvider.autoDispose
    .family<ObjectDetailData?, String>((ref, objectId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final object = await database.objectDao.getById(objectId);
      if (object == null || object.deletedAt != null) {
        return null;
      }
      final installations = await database.installationDao
          .watchForObject(tenantId, objectId)
          .first;
      final history = await database.workOrderDao
          .watchForObject(tenantId, objectId)
          .first;
      return ObjectDetailData(
        object: object,
        installations: installations,
        history: history,
      );
    });

final class ObjectDetailData {
  const ObjectDetailData({
    required this.object,
    required this.installations,
    required this.history,
  });

  final CustomerObjectRow object;
  final List<InstallationRow> installations;
  final List<WorkOrderRow> history;
}

class ObjectDetailScreen extends ConsumerWidget {
  const ObjectDetailScreen({required this.objectId, super.key});

  final String objectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(objectDetailProvider(objectId));

    return Scaffold(
      appBar: AppBar(title: const Text('Objekt')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 5),
          error: (error, stackTrace) => ErrorState(
            title: 'Objekt konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(objectDetailProvider(objectId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.home_work_outlined,
                title: 'Objekt nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
              );
            }
            final object = detail.object;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _ObjectHeader(object: object),
                const SizedBox(height: AppSpacing.md),
                _ObjectNotesCard(
                  objectId: object.id,
                  initialNotes: object.objectNotes,
                ),
                const SizedBox(height: AppSpacing.lg),
                _InstallationList(installations: detail.installations),
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

class _ObjectHeader extends StatelessWidget {
  const _ObjectHeader({required this.object});

  final CustomerObjectRow object;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              object.name,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '${object.street} ${object.houseNumber}, '
              '${object.postalCode} ${object.city}',
            ),
            if (object.accessNotes != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('Zugang: ${object.accessNotes!}'),
            ],
            if (object.safetyNotes != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('Sicherheit: ${object.safetyNotes!}'),
            ],
          ],
        ),
      ),
    );
  }
}

class _ObjectNotesCard extends ConsumerStatefulWidget {
  const _ObjectNotesCard({required this.objectId, required this.initialNotes});

  final String objectId;
  final String? initialNotes;

  @override
  ConsumerState<_ObjectNotesCard> createState() => _ObjectNotesCardState();
}

class _ObjectNotesCardState extends ConsumerState<_ObjectNotesCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void didUpdateWidget(covariant _ObjectNotesCard oldWidget) {
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
              'Objektnotizen',
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
                labelText: 'Notizen zum Objekt',
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
    await database.objectDao.updateNotesLocal(
      id: widget.objectId,
      notes: notes.isEmpty ? null : notes,
    );
    ref.invalidate(objectDetailProvider(widget.objectId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Objektnotizen lokal gespeichert.')),
      );
    }
  }
}

class _InstallationList extends StatelessWidget {
  const _InstallationList({required this.installations});

  final List<InstallationRow> installations;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Anlagen',
      emptyIcon: Icons.fireplace_outlined,
      emptyTitle: 'Keine Anlagen',
      children: installations
          .map(
            (installation) => ListTile(
              leading: const Icon(Icons.fireplace_outlined),
              title: Text(_installationTitle(installation)),
              subtitle: Text(
                installation.locationDescription ?? installation.type,
              ),
              onTap: () => context.push(
                AppRoutes.installationDetailPath(installation.id),
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
      title: 'Objekthistorie',
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
    return 'ohne Termin';
  }
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}
