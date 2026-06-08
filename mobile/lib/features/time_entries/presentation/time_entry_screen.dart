import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/time_entry.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/time_entry_providers.dart';

class TimeEntryScreen extends ConsumerWidget {
  const TimeEntryScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(timeEntriesForWorkOrderProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Zeiten')),
      body: SafeArea(
        child: entries.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Zeiten konnten nicht geladen werden',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(timeEntriesForWorkOrderProvider(workOrderId)),
          ),
          data: (entries) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              _TimeEntryForm(workOrderId: workOrderId),
              const SizedBox(height: AppSpacing.lg),
              if (entries.isEmpty)
                const EmptyState(
                  icon: Icons.timer_outlined,
                  title: 'Keine Zeiten erfasst',
                  message: 'Start/Stop-Zeiten werden lokal gespeichert.',
                )
              else
                ...entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _TimeEntryCard(entry: entry),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeEntryForm extends ConsumerStatefulWidget {
  const _TimeEntryForm({required this.workOrderId});

  final String workOrderId;

  @override
  ConsumerState<_TimeEntryForm> createState() => _TimeEntryFormState();
}

class _TimeEntryFormState extends ConsumerState<_TimeEntryForm> {
  final _durationController = TextEditingController(text: '30');
  final _notesController = TextEditingController();
  TimeEntryType _type = TimeEntryType.work;

  @override
  void dispose() {
    _durationController.dispose();
    _notesController.dispose();
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
              'Zeit erfassen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<TimeEntryType>(
              initialValue: _type,
              items: TimeEntryType.values
                  .map(
                    (type) =>
                        DropdownMenuItem(value: type, child: Text(type.label)),
                  )
                  .toList(growable: false),
              onChanged: (type) {
                if (type != null) {
                  setState(() => _type = type);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Zeittyp',
                prefixIcon: Icon(Icons.timer_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Dauer in Minuten',
                prefixIcon: Icon(Icons.more_time),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _notesController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notizen',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Zeit speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final minutes = int.tryParse(_durationController.text) ?? 0;
    if (minutes <= 0) {
      _showMessage('Dauer muss groesser als 0 sein.');
      return;
    }

    final now = DateTime.now();
    final draft = TimeEntryDraft(
      workOrderId: widget.workOrderId,
      userId: ref.read(activeTechnicianUserIdProvider),
      type: _type,
      startTime: now.subtract(Duration(minutes: minutes)),
      endTime: now,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text,
    );
    final create = await ref.read(createTimeEntryProvider.future);
    await create(draft);
    _notesController.clear();
    _showMessage('Zeit lokal gespeichert.');
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

class _TimeEntryCard extends StatelessWidget {
  const _TimeEntryCard({required this.entry});

  final TimeEntry entry;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM. HH:mm');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.type.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                StatusBadge(
                  label: entry.isOpen
                      ? 'Läuft'
                      : '${entry.durationMinutes ?? 0} min',
                  icon: entry.isOpen ? Icons.play_arrow : Icons.task_alt,
                  tone: entry.isOpen
                      ? StatusBadgeTone.warning
                      : StatusBadgeTone.success,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${formatter.format(entry.startTime.toLocal())} - '
              '${entry.endTime == null ? '--:--' : formatter.format(entry.endTime!.toLocal())}',
            ),
            if (entry.notes != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(entry.notes!),
            ],
          ],
        ),
      ),
    );
  }
}
