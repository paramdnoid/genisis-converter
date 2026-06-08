import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/defect.dart';
import '../../../domain/entities/installation.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/defect_providers.dart';

class DefectScreen extends ConsumerWidget {
  const DefectScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Mängel')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Auftrag konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrderDetailProvider(workOrderId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.report_problem_outlined,
                title: 'Keine Mängel möglich',
                message: 'Der Auftrag ist lokal nicht vorhanden.',
              );
            }
            return _DefectContent(
              workOrderId: workOrderId,
              installations: detail.installations,
            );
          },
        ),
      ),
    );
  }
}

class _DefectContent extends ConsumerWidget {
  const _DefectContent({
    required this.workOrderId,
    required this.installations,
  });

  final String workOrderId;
  final List<Installation> installations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defects = ref.watch(defectsForWorkOrderProvider(workOrderId));

    return defects.when(
      loading: () => const LoadingSkeleton(itemCount: 4),
      error: (error, stackTrace) => ErrorState(
        title: 'Mängel konnten nicht geladen werden',
        message: error.toString(),
        onRetry: () => ref.invalidate(defectsForWorkOrderProvider(workOrderId)),
      ),
      data: (defects) => ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          _DefectForm(workOrderId: workOrderId, installations: installations),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Erfasste Mängel',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.md),
          if (defects.isEmpty)
            const EmptyState(
              icon: Icons.verified_outlined,
              title: 'Keine Mängel erfasst',
              message: 'Neue Mängel werden lokal gespeichert.',
            )
          else
            ...defects.map(
              (defect) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _DefectCard(defect: defect),
              ),
            ),
        ],
      ),
    );
  }
}

class _DefectForm extends ConsumerStatefulWidget {
  const _DefectForm({required this.workOrderId, required this.installations});

  final String workOrderId;
  final List<Installation> installations;

  @override
  ConsumerState<_DefectForm> createState() => _DefectFormState();
}

class _DefectFormState extends ConsumerState<_DefectForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _actionController = TextEditingController();
  DefectSeverity _severity = DefectSeverity.minor;
  String? _installationId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _actionController.dispose();
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
              'Mangel erfassen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<DefectSeverity>(
              initialValue: _severity,
              items: DefectSeverity.values
                  .map(
                    (severity) => DropdownMenuItem(
                      value: severity,
                      child: Text(severity.label),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (severity) {
                if (severity != null) {
                  setState(() => _severity = severity);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Schweregrad',
                prefixIcon: Icon(Icons.priority_high),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String?>(
              initialValue: _installationId,
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Keine Anlage'),
                ),
                ...widget.installations.map(
                  (installation) => DropdownMenuItem<String?>(
                    value: installation.id,
                    child: Text(installation.displayName),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _installationId = value),
              decoration: const InputDecoration(
                labelText: 'Anlage',
                prefixIcon: Icon(Icons.fireplace_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titel',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _descriptionController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Beschreibung',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _actionController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Empfohlene Massnahme',
                prefixIcon: Icon(Icons.build_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Mangel speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final create = await ref.read(createDefectProvider.future);
    final draft = DefectDraft(
      workOrderId: widget.workOrderId,
      installationId: _installationId,
      severity: _severity,
      title: _titleController.text,
      description: _descriptionController.text,
      recommendedAction: _actionController.text.trim().isEmpty
          ? null
          : _actionController.text,
    );
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      _showMessage(errors.join('\n'));
      return;
    }

    await create(draft);
    _titleController.clear();
    _descriptionController.clear();
    _actionController.clear();
    _showMessage('Mangel lokal gespeichert.');
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _DefectCard extends ConsumerWidget {
  const _DefectCard({required this.defect});

  final Defect defect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = defect.isCritical
        ? colorScheme.error
        : colorScheme.outlineVariant;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    defect.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                StatusBadge(
                  label: defect.severity.label,
                  icon: defect.isCritical
                      ? Icons.warning_amber
                      : Icons.info_outline,
                  tone: defect.isCritical
                      ? StatusBadgeTone.error
                      : StatusBadgeTone.warning,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(defect.description),
            if (defect.recommendedAction != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('Massnahme: ${defect.recommendedAction!}'),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                if (defect.isDirty)
                  const StatusBadge(
                    label: 'Lokal',
                    icon: Icons.cloud_upload_outlined,
                    tone: StatusBadgeTone.warning,
                  ),
                const Spacer(),
                TextButton.icon(
                  onPressed: defect.resolved
                      ? null
                      : () async {
                          final resolve = await ref.read(
                            resolveDefectProvider.future,
                          );
                          await resolve(defect.id);
                        },
                  icon: const Icon(Icons.task_alt),
                  label: Text(defect.resolved ? 'Erledigt' : 'Erledigen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
