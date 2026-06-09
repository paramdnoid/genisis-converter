import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/measurement.dart';
import '../../../l10n/app_localizations_x.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/bluetooth_measurement.dart';
import '../application/measurement_providers.dart';

class MeasurementScreen extends ConsumerWidget {
  const MeasurementScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.measurementsTitle)),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.workOrderLoadErrorTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrderDetailProvider(workOrderId)),
          ),
          data: (detail) {
            if (detail == null) {
              return EmptyState(
                icon: Icons.monitor_heart_outlined,
                title: context.l10n.measurementsUnavailableTitle,
                message: context.l10n.reportNoPreviewMessage,
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
        title: context.l10n.measurementsLoadErrorTitle,
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
          _BluetoothMeasurementImportPanel(
            workOrderId: workOrderId,
            installations: installations,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.recordedMeasurementsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.md),
          if (measurements.isEmpty)
            EmptyState(
              icon: Icons.speed_outlined,
              title: context.l10n.measurementsEmptyTitle,
              message: context.l10n.measurementsEmptyMessage,
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

class _BluetoothMeasurementImportPanel extends ConsumerStatefulWidget {
  const _BluetoothMeasurementImportPanel({
    required this.workOrderId,
    required this.installations,
  });

  final String workOrderId;
  final List<Installation> installations;

  @override
  ConsumerState<_BluetoothMeasurementImportPanel> createState() =>
      _BluetoothMeasurementImportPanelState();
}

class _BluetoothMeasurementImportPanelState
    extends ConsumerState<_BluetoothMeasurementImportPanel> {
  StreamSubscription<List<BluetoothMeasurementReading>>? _readingSubscription;
  final _readings = <BluetoothMeasurementReading>[];
  late final BluetoothMeasurementClient _client;
  String? _installationId;
  String? _selectedDeviceId;
  String? _errorMessage;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _client = ref.read(bluetoothMeasurementClientProvider);
  }

  @override
  void dispose() {
    final selectedDeviceId = _selectedDeviceId;
    if (selectedDeviceId != null) {
      unawaited(_client.disconnect(selectedDeviceId));
    }
    unawaited(_readingSubscription?.cancel() ?? Future<void>.value());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(bluetoothMeasurementDevicesProvider);
    final isScanning = ref
        .watch(bluetoothMeasurementScanningProvider)
        .maybeWhen(data: (value) => value, orElse: () => false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bluetooth_searching_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    context.l10n.bluetoothMeasurementTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.l10n.bluetoothMeasurementSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String?>(
              initialValue: _installationId,
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(context.l10n.noInstallationOption),
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
              decoration: InputDecoration(
                labelText: context.l10n.installationFieldLabel,
                prefixIcon: const Icon(Icons.fireplace_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                FilledButton.icon(
                  onPressed: isScanning ? null : _startScan,
                  icon: const Icon(Icons.bluetooth_searching_outlined),
                  label: Text(context.l10n.startBluetoothScanAction),
                ),
                OutlinedButton.icon(
                  onPressed: isScanning ? _stopScan : null,
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: Text(context.l10n.stopBluetoothScanAction),
                ),
              ],
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            devices.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
              data: (devices) {
                if (devices.isEmpty) {
                  return Text(context.l10n.bluetoothDevicesEmptyMessage);
                }

                return Column(
                  children: devices
                      .take(6)
                      .map(
                        (device) => _BluetoothDeviceTile(
                          device: device,
                          selected: device.id == _selectedDeviceId,
                          connecting:
                              _isConnecting && device.id == _selectedDeviceId,
                          onTap: () => _connect(device),
                        ),
                      )
                      .toList(growable: false),
                );
              },
            ),
            if (_readings.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              ..._readings.map(
                (reading) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _BluetoothReadingTile(
                    reading: reading,
                    onSave: () => _saveReading(reading),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _startScan() async {
    setState(() => _errorMessage = null);
    try {
      await _client.startScan();
    } catch (error) {
      setState(() => _errorMessage = error.toString());
    }
  }

  Future<void> _stopScan() async {
    try {
      await _client.stopScan();
    } catch (error) {
      setState(() => _errorMessage = error.toString());
    }
  }

  Future<void> _connect(BluetoothMeasurementDevice device) async {
    await _readingSubscription?.cancel();
    setState(() {
      _selectedDeviceId = device.id;
      _isConnecting = true;
      _errorMessage = null;
      _readings.clear();
    });

    _readingSubscription = _client
        .connectAndWatchReadings(device.id)
        .listen(
          (readings) {
            if (!mounted) {
              return;
            }
            setState(() {
              _isConnecting = false;
              _readings.insertAll(0, readings);
            });
          },
          onError: (Object error) {
            if (!mounted) {
              return;
            }
            setState(() {
              _isConnecting = false;
              _errorMessage = error.toString();
            });
          },
        );
  }

  Future<void> _saveReading(BluetoothMeasurementReading reading) async {
    final savedMessage = context.l10n.bluetoothReadingSavedMessage;
    try {
      final save = await ref.read(saveMeasurementProvider.future);
      await save(
        reading.toDraft(
          workOrderId: widget.workOrderId,
          installationId: _installationId,
        ),
      );
      _showMessage(savedMessage);
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

class _BluetoothDeviceTile extends StatelessWidget {
  const _BluetoothDeviceTile({
    required this.device,
    required this.selected,
    required this.connecting,
    required this.onTap,
  });

  final BluetoothMeasurementDevice device;
  final bool selected;
  final bool connecting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey('bluetooth-device-${device.id}'),
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.bluetooth_connected : Icons.bluetooth_outlined,
      ),
      title: Text(device.displayName),
      subtitle: Text('${device.id} · RSSI ${device.rssi}'),
      trailing: connecting
          ? Text(context.l10n.bluetoothDeviceConnectingStatus)
          : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _BluetoothReadingTile extends StatelessWidget {
  const _BluetoothReadingTile({required this.reading, required this.onSave});

  final BluetoothMeasurementReading reading;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final deviceName = reading.deviceName;
    final deviceSerial = reading.deviceSerial;
    final deviceText = [
      if (deviceName != null && deviceName.trim().isNotEmpty) deviceName,
      if (deviceSerial != null && deviceSerial.trim().isNotEmpty) deviceSerial,
    ].join(' · ');

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reading.type.label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('${context.formatDecimal(reading.value)} ${reading.unit}'),
            if (deviceText.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text('${context.l10n.measurementDeviceLabel}: $deviceText'),
            ],
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.download_done_outlined),
                label: Text(context.l10n.bluetoothReadingSaveAction),
              ),
            ),
          ],
        ),
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
              decoration: InputDecoration(
                labelText: context.l10n.measurementTypeLabel,
                prefixIcon: const Icon(Icons.monitor_heart_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String?>(
              initialValue: _installationId,
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(context.l10n.noInstallationOption),
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
              decoration: InputDecoration(
                labelText: context.l10n.installationFieldLabel,
                prefixIcon: const Icon(Icons.fireplace_outlined),
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
                    decoration: InputDecoration(
                      labelText: context.l10n.valueFieldLabel,
                      prefixIcon: const Icon(Icons.pin_outlined),
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
                    decoration: InputDecoration(
                      labelText: context.l10n.unitFieldLabel,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _notesController,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: context.l10n.notesFieldLabel,
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(context.l10n.saveMeasurementAction),
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
                  StatusBadge(
                    label: context.l10n.locallyChangedStatus,
                    icon: Icons.cloud_upload_outlined,
                    tone: StatusBadgeTone.warning,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${context.formatDecimal(measurement.value)} ${measurement.unit}',
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(context.formatShortDateTime(measurement.measuredAt)),
            if (measurement.deviceName != null ||
                measurement.deviceSerial != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${context.l10n.measurementDeviceLabel}: '
                '${[if (measurement.deviceName != null) measurement.deviceName!, if (measurement.deviceSerial != null) measurement.deviceSerial!].join(' · ')}',
              ),
            ],
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
