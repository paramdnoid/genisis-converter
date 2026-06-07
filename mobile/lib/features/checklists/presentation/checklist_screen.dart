import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/checklist.dart';
import '../../../domain/enums/checklist_answer_type.dart';
import '../../work_orders/application/work_order_providers.dart';
import '../application/checklist_providers.dart';

class ChecklistScreen extends ConsumerWidget {
  const ChecklistScreen({required this.workOrderId, super.key});

  final String workOrderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(workOrderDetailProvider(workOrderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Checkliste')),
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
                icon: Icons.checklist,
                title: 'Keine Checkliste verfügbar',
                message: 'Der Auftrag ist lokal nicht vorhanden.',
              );
            }

            final request = (
              workOrderId: workOrderId,
              workOrderType: detail.workOrder.type,
            );
            final items = ref.watch(checklistItemsProvider(request));

            return items.when(
              loading: () => const LoadingSkeleton(itemCount: 6),
              error: (error, stackTrace) => ErrorState(
                title: 'Checkliste konnte nicht geladen werden',
                message: error.toString(),
                onRetry: () => ref.invalidate(checklistItemsProvider(request)),
              ),
              data: (items) => _ChecklistContent(items: items),
            );
          },
        ),
      ),
    );
  }
}

class _ChecklistContent extends StatelessWidget {
  const _ChecklistContent({required this.items});

  final List<ChecklistItemState> items;

  @override
  Widget build(BuildContext context) {
    final progress = ChecklistProgress.fromItems(items);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        _ProgressCard(progress: progress),
        const SizedBox(height: AppSpacing.lg),
        if (items.isEmpty)
          const EmptyState(
            icon: Icons.checklist_rtl,
            title: 'Keine Vorlage gefunden',
            message:
                'Für diesen Auftragstyp existiert lokal keine aktive Vorlage.',
          )
        else
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _ChecklistAnswerCard(state: item),
            ),
          ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.progress});

  final ChecklistProgress progress;

  @override
  Widget build(BuildContext context) {
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
                    'Fortschritt',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                StatusBadge(
                  label: '${progress.completed}/${progress.total}',
                  icon: Icons.check_circle_outline,
                  tone: progress.isValid
                      ? StatusBadgeTone.success
                      : StatusBadgeTone.warning,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            LinearProgressIndicator(value: progress.ratio),
            if (!progress.isValid) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Offene Pflichtfragen: ${progress.missingRequired.join(', ')}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChecklistAnswerCard extends ConsumerStatefulWidget {
  const _ChecklistAnswerCard({required this.state});

  final ChecklistItemState state;

  @override
  ConsumerState<_ChecklistAnswerCard> createState() =>
      _ChecklistAnswerCardState();
}

class _ChecklistAnswerCardState extends ConsumerState<_ChecklistAnswerCard> {
  late final TextEditingController _valueController;
  late final TextEditingController _commentController;
  Timer? _debounce;
  String? _answerValue;
  String? _comment;
  bool? _isOk;

  @override
  void initState() {
    super.initState();
    _answerValue = widget.state.answer.answerValue;
    _comment = widget.state.answer.comment;
    _isOk = widget.state.answer.isOk;
    _valueController = TextEditingController(text: _answerValue ?? '');
    _commentController = TextEditingController(text: _comment ?? '');
  }

  @override
  void didUpdateWidget(covariant _ChecklistAnswerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.answer.id != widget.state.answer.id) {
      _answerValue = widget.state.answer.answerValue;
      _comment = widget.state.answer.comment;
      _isOk = widget.state.answer.isOk;
      _valueController.text = _answerValue ?? '';
      _commentController.text = _comment ?? '';
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _valueController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.state.item;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (item.required)
                  const StatusBadge(
                    label: 'Pflicht',
                    icon: Icons.priority_high,
                    tone: StatusBadgeTone.warning,
                  ),
              ],
            ),
            if (item.helpText != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(item.helpText!),
            ],
            const SizedBox(height: AppSpacing.md),
            _buildAnswerWidget(item),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _commentController,
              minLines: 1,
              maxLines: 3,
              onChanged: (value) {
                _comment = value;
                _scheduleSave();
              },
              decoration: const InputDecoration(
                labelText: 'Kommentar',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            if (widget.state.answer.isDirty) ...[
              const SizedBox(height: AppSpacing.md),
              const StatusBadge(
                label: 'Lokal gespeichert',
                icon: Icons.cloud_upload_outlined,
                tone: StatusBadgeTone.warning,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerWidget(ChecklistTemplateItem item) {
    return switch (item.answerType) {
      ChecklistAnswerType.yesNo => SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'yes', label: Text('Ja')),
          ButtonSegment(value: 'no', label: Text('Nein')),
        ],
        selected: _answerValue == null || _answerValue!.isEmpty
            ? <String>{}
            : <String>{_answerValue!},
        emptySelectionAllowed: true,
        onSelectionChanged: (selection) {
          final value = selection.isEmpty ? null : selection.single;
          _setAnswer(value, isOk: value == null ? null : value == 'yes');
        },
      ),
      ChecklistAnswerType.text => TextField(
        controller: _valueController,
        minLines: 1,
        maxLines: 4,
        onChanged: (value) => _setAnswer(value, debounce: true),
        decoration: const InputDecoration(
          labelText: 'Antwort',
          prefixIcon: Icon(Icons.short_text),
        ),
      ),
      ChecklistAnswerType.number => TextField(
        controller: _valueController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
        ],
        onChanged: (value) => _setAnswer(value, debounce: true),
        decoration: const InputDecoration(
          labelText: 'Zahl',
          prefixIcon: Icon(Icons.pin_outlined),
        ),
      ),
      ChecklistAnswerType.singleSelect => DropdownButtonFormField<String>(
        initialValue: item.options.contains(_answerValue) ? _answerValue : null,
        items: item.options
            .map(
              (option) =>
                  DropdownMenuItem<String>(value: option, child: Text(option)),
            )
            .toList(growable: false),
        onChanged: (value) => _setAnswer(value),
        decoration: const InputDecoration(
          labelText: 'Auswahl',
          prefixIcon: Icon(Icons.radio_button_checked),
        ),
      ),
      ChecklistAnswerType.multiSelect => Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: item.options
            .map((option) {
              final selected = _selectedOptions.contains(option);
              return FilterChip(
                selected: selected,
                label: Text(option),
                onSelected: (nextSelected) {
                  final next = [..._selectedOptions];
                  if (nextSelected) {
                    next.add(option);
                  } else {
                    next.remove(option);
                  }
                  _setAnswer(jsonEncode(next));
                },
              );
            })
            .toList(growable: false),
      ),
      ChecklistAnswerType.photoRequired => CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        value: _answerValue == 'acknowledged',
        onChanged: (checked) {
          _setAnswer(checked == true ? 'acknowledged' : null, isOk: checked);
        },
        title: const Text('Fotopflicht notiert'),
        controlAffinity: ListTileControlAffinity.leading,
      ),
      ChecklistAnswerType.unknown => const Text('Unbekannter Antworttyp.'),
    };
  }

  List<String> get _selectedOptions {
    final value = _answerValue;
    if (value == null || value.trim().isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(value);
    if (decoded is! List) {
      return const [];
    }

    return decoded.map((item) => item.toString()).toList(growable: false);
  }

  void _setAnswer(String? value, {bool debounce = false, bool? isOk}) {
    setState(() {
      _answerValue = value;
      _isOk = isOk ?? _isOkForValue(value);
    });

    if (debounce) {
      _scheduleSave();
    } else {
      _save();
    }
  }

  bool? _isOkForValue(String? value) {
    if (widget.state.item.answerType == ChecklistAnswerType.yesNo) {
      return value == null ? null : value == 'yes';
    }

    return value == null || value.trim().isEmpty ? null : true;
  }

  void _scheduleSave() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), _save);
  }

  Future<void> _save() async {
    final useCase = await ref.read(saveChecklistAnswerProvider.future);
    await useCase(
      answerId: widget.state.answer.id,
      answerValue: _answerValue,
      comment: _comment,
      isOk: _isOk,
    );
  }
}
