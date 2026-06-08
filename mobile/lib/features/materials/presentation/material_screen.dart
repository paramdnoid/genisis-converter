import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/material_usage.dart';
import '../application/material_providers.dart';

class MaterialScreen extends ConsumerWidget {
  const MaterialScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usages = ref.watch(materialsForWorkOrderProvider(workOrderId));
    final catalog = ref.watch(materialCatalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Material')),
      body: SafeArea(
        child: usages.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Material konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(materialsForWorkOrderProvider(workOrderId)),
          ),
          data: (usages) => catalog.when(
            loading: () => const LoadingSkeleton(itemCount: 4),
            error: (error, stackTrace) => ErrorState(
              title: 'Materialstamm konnte nicht geladen werden',
              message: error.toString(),
              onRetry: () => ref.invalidate(materialCatalogProvider),
            ),
            data: (catalog) => ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              children: [
                _MaterialForm(workOrderId: workOrderId, catalog: catalog),
                const SizedBox(height: AppSpacing.lg),
                if (usages.isEmpty)
                  const EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Kein Material erfasst',
                    message: 'Verbrauch wird lokal am Auftrag gespeichert.',
                  )
                else
                  ...usages.map(
                    (usage) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _MaterialCard(usage: usage),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MaterialForm extends ConsumerStatefulWidget {
  const _MaterialForm({required this.workOrderId, required this.catalog});

  final String workOrderId;
  final List<MaterialItem> catalog;

  @override
  ConsumerState<_MaterialForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<_MaterialForm> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _unitController = TextEditingController(text: 'Stueck');
  final _notesController = TextEditingController();
  String? _materialId;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
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
              'Material erfassen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String?>(
              initialValue: _materialId,
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Freitext'),
                ),
                ...widget.catalog.map(
                  (item) => DropdownMenuItem<String?>(
                    value: item.id,
                    child: Text(item.name),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _materialId = value;
                  MaterialItem? item;
                  for (final candidate in widget.catalog) {
                    if (candidate.id == value) {
                      item = candidate;
                      break;
                    }
                  }
                  if (item != null) {
                    _nameController.text = item.name;
                    _unitController.text = item.unit;
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Materialstamm',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Bezeichnung',
                prefixIcon: Icon(Icons.edit_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    decoration: const InputDecoration(labelText: 'Menge'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _unitController,
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
              label: const Text('Material speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final quantity =
        double.tryParse(_quantityController.text.replaceAll(',', '.')) ?? 0;
    final draft = WorkOrderMaterialDraft(
      workOrderId: widget.workOrderId,
      materialId: _materialId,
      name: _nameController.text,
      quantity: quantity,
      unit: _unitController.text,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text,
    );
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      _showMessage(errors.join('\n'));
      return;
    }

    final create = await ref.read(createMaterialUsageProvider.future);
    await create(draft);
    _quantityController.text = '1';
    _notesController.clear();
    _showMessage('Material lokal gespeichert.');
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

class _MaterialCard extends StatelessWidget {
  const _MaterialCard({required this.usage});

  final WorkOrderMaterial usage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usage.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text('${usage.quantity} ${usage.unit}'),
                  if (usage.notes != null) Text(usage.notes!),
                ],
              ),
            ),
            if (usage.isDirty)
              const StatusBadge(
                label: 'Lokal',
                icon: Icons.cloud_upload_outlined,
                tone: StatusBadgeTone.warning,
              ),
          ],
        ),
      ),
    );
  }
}
