import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/enums/work_order_status.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/work_order_history_summary.dart';

class WorkOrderHistorySection extends StatelessWidget {
  const WorkOrderHistorySection({
    required this.title,
    required this.emptyTitle,
    required this.history,
    super.key,
  });

  final String title;
  final String emptyTitle;
  final List<WorkOrder> history;

  @override
  Widget build(BuildContext context) {
    final summary = WorkOrderHistorySummary.from(history);

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
            if (summary.totalCount == 0)
              EmptyState(
                icon: Icons.history_outlined,
                title: emptyTitle,
                message: '',
              )
            else ...[
              const SizedBox(height: AppSpacing.xs),
              _HistoryMetrics(summary: summary),
              const SizedBox(height: AppSpacing.md),
              _HistoryMilestones(summary: summary),
              const Divider(height: AppSpacing.xl),
              ...summary.groups.expand(
                (group) => [
                  _HistoryMonthHeader(month: group.month),
                  ...group.orders.map((order) => _HistoryTile(order: order)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HistoryMetrics extends StatelessWidget {
  const _HistoryMetrics({required this.summary});

  final WorkOrderHistorySummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _MetricTile(
          icon: Icons.assignment_outlined,
          value: summary.totalCount.toString(),
          label: l10n.historyTotalMetricLabel,
        ),
        _MetricTile(
          icon: Icons.task_alt_outlined,
          value: summary.completedCount.toString(),
          label: l10n.historyCompletedMetricLabel,
        ),
        _MetricTile(
          icon: Icons.pending_actions_outlined,
          value: summary.openCount.toString(),
          label: l10n.historyOpenMetricLabel,
        ),
        _MetricTile(
          icon: Icons.warning_amber_outlined,
          value: summary.overdueCount.toString(),
          label: l10n.historyOverdueMetricLabel,
          tone: _MetricTone.warning,
        ),
        _MetricTile(
          icon: Icons.sync_problem_outlined,
          value: summary.localChangeCount.toString(),
          label: l10n.historyLocalMetricLabel,
          tone: summary.localChangeCount == 0
              ? _MetricTone.neutral
              : _MetricTone.warning,
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.value,
    required this.label,
    this.tone = _MetricTone.neutral,
  });

  final IconData icon;
  final String value;
  final String label;
  final _MetricTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (tone) {
      _MetricTone.neutral => theme.colorScheme.primary,
      _MetricTone.warning =>
        theme.extension<AppSemanticColors>()?.warning ??
            theme.colorScheme.error,
    };

    return SizedBox(
      width: 128,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                    Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryMilestones extends StatelessWidget {
  const _HistoryMilestones({required this.summary});

  final WorkOrderHistorySummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MilestoneRow(
          icon: Icons.verified_outlined,
          label: context.l10n.historyLastCompletedLabel,
          value: _orderMilestoneText(
            context,
            summary.lastCompleted,
            emptyText: context.l10n.historyNoCompletedOrders,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _MilestoneRow(
          icon: Icons.event_available_outlined,
          label: context.l10n.historyNextScheduledLabel,
          value: _orderMilestoneText(
            context,
            summary.nextScheduled,
            emptyText: context.l10n.historyNoUpcomingOrders,
          ),
        ),
      ],
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryMonthHeader extends StatelessWidget {
  const _HistoryMonthHeader({required this.month});

  final DateTime? month;

  @override
  Widget build(BuildContext context) {
    final text = month == null
        ? context.l10n.noDate
        : DateFormat.yMMMM(context.l10n.localeName).format(month!);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.order});

  final WorkOrder order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      leading: const Icon(Icons.assignment_outlined),
      title: Text(order.title),
      subtitle: Text(
        '${order.orderNumber} · ${_formatDate(context, order.scheduledStart)}',
      ),
      trailing: StatusBadge(
        label: order.status.label,
        icon: _statusIcon(order.status),
        tone: _statusTone(order.status),
      ),
      onTap: () => context.push(AppRoutes.workOrderDetailPath(order.id)),
    );
  }
}

String _orderMilestoneText(
  BuildContext context,
  WorkOrder? order, {
  required String emptyText,
}) {
  if (order == null) {
    return emptyText;
  }
  return '${order.orderNumber} · ${_formatDate(context, order.scheduledStart)}';
}

String _formatDate(BuildContext context, DateTime? value) {
  if (value == null) {
    return context.l10n.noAppointment;
  }
  return context.formatShortDate(value);
}

IconData _statusIcon(WorkOrderStatus status) {
  return switch (status) {
    WorkOrderStatus.completed || WorkOrderStatus.synced => Icons.task_alt,
    WorkOrderStatus.cancelled => Icons.cancel_outlined,
    WorkOrderStatus.inProgress => Icons.play_circle_outline,
    WorkOrderStatus.paused => Icons.pause_circle_outline,
    WorkOrderStatus.scheduled => Icons.event_available_outlined,
    WorkOrderStatus.draft => Icons.edit_note_outlined,
    WorkOrderStatus.unknown => Icons.help_outline,
  };
}

StatusBadgeTone _statusTone(WorkOrderStatus status) {
  return switch (status) {
    WorkOrderStatus.completed ||
    WorkOrderStatus.synced => StatusBadgeTone.success,
    WorkOrderStatus.cancelled => StatusBadgeTone.error,
    WorkOrderStatus.inProgress ||
    WorkOrderStatus.paused ||
    WorkOrderStatus.scheduled => StatusBadgeTone.warning,
    WorkOrderStatus.draft || WorkOrderStatus.unknown => StatusBadgeTone.neutral,
  };
}

enum _MetricTone { neutral, warning }
