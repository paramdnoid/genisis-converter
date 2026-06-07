import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/measurement.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/measurement_providers.dart';

class MeasurementScreen extends ConsumerWidget {
  const MeasurementScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Messungen')),
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
                icon: Icons.monitor_heart_outlined,
                title: 'Keine Messungen möglich',
                message: 'Der Auftrag ist lokal nicht vorhanden.',
              );
            }

            return _MeasurementContent(
              workOrderId: workOrderId,
              installations: detail.installations,
            );
          },
        ),
      ),
    );
  }
}

class _MeasurementContent extends ConsumerWidget {
  const _MeasurementContent({
    required this.workOrderId,
    required this.installations,
  });

  final String workOrderId;
  final List<Installation> installations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final measurements = ref.watch(
      measurementsForWorkOrderProvider(workOrderId),
    );

    return measurements.when(
      loading: () => const LoadingSkeleton(itemCount: 4),
      error: (error, stackTrace) => ErrorState(
        title: 'Messungen konnten nicht geladen werden',
        message: error.toString(),
        onRetry: () =>
            ref.invalidate(measurementsForWorkOrderProvider(workOrderId)),
      ),
      data: (measurements) => ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          _MeasurementForm(
            workOrderId: workOrderId,
            installations: installations,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Erfasste Messungen',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.md),
          if (measurements.isEmpty)
            const EmptyState(
              icon: Icons.speed_outlined,
              title: 'Keine Messwerte erfasst',
              message: 'Neue Messwerte werden lokal gespeichert.',
            )
          else
            ...measurements.map(
              (measurement) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _MeasurementCard(measurement: measurement),
              ),
            ),
        ],
      ),
    );
  }
}

class _MeasurementForm extends ConsumerStatefulWidget {
  const _MeasurementForm({
    required this.workOrderId,
    required this.installations,
  });

  final String workOrderId;
  final List<Installation> installations;

  @override
  ConsumerState<_MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends ConsumerState<_MeasurementForm> {
  final _valueController = TextEditingController();
  final _notesController = TextEditingController();
  MeasurementType _type = MeasurementType.co;
  String _unit = MeasurementRules.forType(MeasurementType.co).defaultUnit;
  String? _installationId;

  @override
  void dispose() {
    _valueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rule = MeasurementRules.forType(_type);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messwert erfassen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<MeasurementType>(
              initialValue: _type,
              items: MeasurementType.values
                  .map(
                    (type) =>
                        DropdownMenuItem(value: type, child: Text(type.label)),
                  )
                  .toList(growable: false),
              onChanged: (type) {
                if (type == null) {
                  return;
                }

                setState(() {
                  _type = type;
                  _unit = MeasurementRules.forType(type).defaultUnit;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Messart',
                prefixIcon: Icon(Icons.monitor_heart_outlined),
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
              onChanged: (installationId) {
                setState(() => _installationId = installationId);
              },
              decoration: const InputDecoration(
                labelText: 'Anlage',
                prefixIcon: Icon(Icons.fireplace_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _valueController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Wert',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                SizedBox(
                  width: 152,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: rule.units.contains(_unit)
                        ? _unit
                        : rule.defaultUnit,
                    items: rule.units
                        .map(
                          (unit) =>
                              DropdownMenuItem(value: unit, child: Text(unit)),
                        )
                        .toList(growable: false),
                    onChanged: (unit) {
                      if (unit != null) {
                        setState(() => _unit = unit);
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Einheit'),
                  ),
                ),
              ],
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
              label: const Text('Messwert speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final rawValue = _valueController.text.trim().replaceAll(',', '.');
    final value = double.tryParse(rawValue);
    if (value == null) {
      _showMessage('Bitte einen gültigen Messwert eingeben.');
      return;
    }

    final draft = MeasurementDraft(
      workOrderId: widget.workOrderId,
      installationId: _installationId,
      type: _type,
      value: value,
      unit: _unit,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    try {
      final save = await ref.read(saveMeasurementProvider.future);
      await save(draft);
      _valueController.clear();
      _notesController.clear();
      _showMessage('Messwert lokal gespeichert.');
    } on AppError catch (error) {
      final missingItems = error.metadata['missingItems'];
      if (missingItems is List) {
        _showMessage(missingItems.whereType<String>().join('\n'));
      } else {
        _showMessage(error.userMessage);
      }
    }
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

class _MeasurementCard extends StatelessWidget {
  const _MeasurementCard({required this.measurement});

  final Measurement measurement;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    measurement.type.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (measurement.isDirty)
                  const StatusBadge(
                    label: 'Lokal',
                    icon: Icons.cloud_upload_outlined,
                    tone: StatusBadgeTone.warning,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('${measurement.value} ${measurement.unit}'),
            const SizedBox(height: AppSpacing.xs),
            Text(
              DateFormat(
                'dd.MM.yyyy HH:mm',
              ).format(measurement.measuredAt.toLocal()),
            ),
            if (measurement.notes != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(measurement.notes!),
            ],
          ],
        ),
      ),
    );
  }
}
