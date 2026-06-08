import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/sync/sync_providers.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/enums/work_order_status.dart';
import '../../work_orders/application/work_order_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayOrders = ref.watch(todayWorkOrdersProvider);
    final pendingSyncs = ref.watch(
      pendingOutboxCountProvider.select(
        (value) => value.maybeWhen(data: (count) => count, orElse: () => 0),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Heute'),
        actions: [
          IconButton(
            tooltip: 'Synchronisieren',
            onPressed: () => ref.invalidate(syncNowProvider),
            icon: const Icon(Icons.sync),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SafeArea(
        child: todayOrders.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: 'Lokale Aufträge konnten nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(todayWorkOrdersProvider),
          ),
          data: (orders) =>
              _DashboardContent(orders: orders, pendingSyncs: pendingSyncs),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.orders, required this.pendingSyncs});

  final List<WorkOrder> orders;
  final int pendingSyncs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        _OfflineBanner(pendingSyncs: pendingSyncs),
        const SizedBox(height: AppSpacing.lg),
        _MetricGrid(orders: orders, pendingSyncs: pendingSyncs),
        const SizedBox(height: AppSpacing.lg),
        if (orders.isEmpty)
          EmptyState(
            icon: Icons.event_available,
            title: 'Keine Aufträge für heute',
            message: 'Neue Daten werden nach dem nächsten Sync lokal sichtbar.',
            action: FilledButton.icon(
              onPressed: () => context.go(AppRoutes.workOrders),
              icon: const Icon(Icons.list_alt),
              label: const Text('Alle Aufträge öffnen'),
            ),
          )
        else
          _NextOrderCard(order: orders.first),
        const SizedBox(height: AppSpacing.lg),
        _SyncStatusCard(pendingSyncs: pendingSyncs),
        const SizedBox(height: AppSpacing.lg),
        const _QuickActions(),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.pendingSyncs});

  final int pendingSyncs;

  @override
  Widget build(BuildContext context) {
    final semanticColors = Theme.of(context).extension<AppSemanticColors>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: semanticColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: semanticColors.warning.withValues(alpha: 0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            const Icon(Icons.wifi_off),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                pendingSyncs == 0
                    ? 'Offline bereit. Lokale Daten sind synchron.'
                    : '$pendingSyncs lokale Änderung(en) warten auf Sync.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.orders, required this.pendingSyncs});

  final List<WorkOrder> orders;
  final int pendingSyncs;

  @override
  Widget build(BuildContext context) {
    final criticalCount = orders
        .where((order) => order.priority == WorkOrderPriority.urgent)
        .length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 520;
        return GridView.count(
          crossAxisCount: isWide ? 3 : 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isWide ? 1.9 : 1.45,
          children: [
            _MetricCard(
              label: 'Aufträge',
              value: orders.length.toString(),
              icon: Icons.event_note,
            ),
            _MetricCard(
              label: 'Offene Syncs',
              value: pendingSyncs.toString(),
              icon: Icons.sync,
            ),
            _MetricCard(
              label: 'Dringend',
              value: criticalCount.toString(),
              icon: Icons.warning_amber,
            ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _NextOrderCard extends ConsumerWidget {
  const _NextOrderCard({required this.order});

  final WorkOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    'Nächster Auftrag',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _WorkOrderStatusBadge(order: order),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              order.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('${order.orderNumber} · ${_timeRange(order)}'),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: order.status.canStart
                        ? () async {
                            final startWorkOrder = await ref.read(
                              startWorkOrderProvider.future,
                            );
                            await startWorkOrder(order.id);
                          }
                        : null,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Starten'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                IconButton.outlined(
                  tooltip: 'Alle Aufträge',
                  onPressed: () => context.go(AppRoutes.workOrders),
                  icon: const Icon(Icons.list_alt),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SyncStatusCard extends StatelessWidget {
  const _SyncStatusCard({required this.pendingSyncs});

  final int pendingSyncs;

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
                    'Sync-Status',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    pendingSyncs == 0
                        ? 'Keine lokalen Änderungen in der Outbox.'
                        : 'Outbox wartet auf die nächste Verbindung.',
                  ),
                ],
              ),
            ),
            StatusBadge(
              label: pendingSyncs == 0 ? 'Synchron' : '$pendingSyncs offen',
              icon: pendingSyncs == 0 ? Icons.cloud_done : Icons.cloud_upload,
              tone: pendingSyncs == 0
                  ? StatusBadgeTone.success
                  : StatusBadgeTone.warning,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schnellaktionen',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.search),
                icon: const Icon(Icons.search),
                label: const Text('Suche'),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.settings),
                icon: const Icon(Icons.settings_outlined),
                label: const Text('Einstellungen'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WorkOrderStatusBadge extends StatelessWidget {
  const _WorkOrderStatusBadge({required this.order});

  final WorkOrder order;

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: order.status.label,
      icon: switch (order.status) {
        WorkOrderStatus.completed || WorkOrderStatus.synced => Icons.task_alt,
        WorkOrderStatus.inProgress => Icons.construction,
        WorkOrderStatus.paused => Icons.pause_circle,
        WorkOrderStatus.cancelled => Icons.cancel_outlined,
        _ => Icons.schedule,
      },
      tone: switch (order.status) {
        WorkOrderStatus.completed ||
        WorkOrderStatus.synced => StatusBadgeTone.success,
        WorkOrderStatus.inProgress ||
        WorkOrderStatus.paused => StatusBadgeTone.warning,
        WorkOrderStatus.cancelled => StatusBadgeTone.error,
        _ => StatusBadgeTone.neutral,
      },
    );
  }
}

String _timeRange(WorkOrder order) {
  final formatter = DateFormat('HH:mm');
  final start = order.scheduledStart?.toLocal();
  final end = order.scheduledEnd?.toLocal();

  if (start == null && end == null) {
    return 'ohne Termin';
  }

  if (start != null && end != null) {
    return '${formatter.format(start)}-${formatter.format(end)}';
  }

  return formatter.format(start ?? end!);
}
