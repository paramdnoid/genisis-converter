import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../domain/entities/customer_object.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/work_order.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/customer_object_providers.dart';

class ObjectDetailScreen extends ConsumerWidget {
  const ObjectDetailScreen({required this.objectId, super.key});

  final String objectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(customerObjectDetailProvider(objectId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.objectTitle)),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 5),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.objectLoadErrorTitle,
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(customerObjectDetailProvider(objectId)),
          ),
          data: (detail) {
            if (detail == null) {
              return EmptyState(
                icon: Icons.home_work_outlined,
                title: context.l10n.objectNotFoundTitle,
                message: context.l10n.localRecordMissingMessage,
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

  final CustomerObject object;

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
              Text('${context.l10n.accessNotesLabel}: ${object.accessNotes!}'),
            ],
            if (object.safetyNotes != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('${context.l10n.safetyNotesLabel}: ${object.safetyNotes!}'),
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
              context.l10n.objectNotesTitle,
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
                labelText: context.l10n.objectNotesLabel,
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
    final repository = await ref.read(customerObjectRepositoryProvider.future);
    final notes = _controller.text.trim();
    await repository.updateNotes(
      id: widget.objectId,
      notes: notes.isEmpty ? null : notes,
    );
    ref.invalidate(customerObjectDetailProvider(widget.objectId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.objectNotesSavedMessage)),
      );
    }
  }
}

class _InstallationList extends StatelessWidget {
  const _InstallationList({required this.installations});

  final List<Installation> installations;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.installationsTitle,
      emptyIcon: Icons.fireplace_outlined,
      emptyTitle: context.l10n.installationsEmptyTitle,
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

  final List<WorkOrder> history;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.objectHistoryTitle,
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
    return context.l10n.noAppointment;
  }
  return context.formatShortDate(value);
}
