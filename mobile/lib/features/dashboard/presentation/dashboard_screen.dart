import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/sync/sync_providers.dart';
import '../../../domain/entities/recurring_work_order_candidate.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/entities/work_order_route_stop.dart';
import '../../../domain/enums/work_order_status.dart';
import '../../../l10n/app_localizations_x.dart';
import '../../customers/application/customer_providers.dart';
import '../../installations/application/installation_providers.dart';
import '../../objects/application/customer_object_providers.dart';
import '../../work_orders/application/work_order_route_optimizer.dart';
import '../../work_orders/application/work_order_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayOrders = ref.watch(todayWorkOrdersProvider);
    final routeStops = ref.watch(todayRouteStopsProvider);
    final dueRecurring = ref.watch(dueRecurringWorkOrdersProvider);
    final pendingSyncs = ref.watch(
      pendingOutboxCountProvider.select(
        (value) => value.maybeWhen(data: (count) => count, orElse: () => 0),
      ),
    );
    final recordCounts = _DashboardRecordCounts(
      customers: ref.watch(customersProvider.select(_asyncListCount)),
      objects: ref.watch(customerObjectsProvider('').select(_asyncListCount)),
      installations: ref.watch(
        installationListProvider('').select(_asyncListCount),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dashboardTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.syncActionTooltip,
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
            title: context.l10n.dashboardLoadErrorTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(todayWorkOrdersProvider),
          ),
          data: (orders) => _DashboardContent(
            orders: orders,
            routeStops: routeStops,
            dueRecurring: dueRecurring,
            pendingSyncs: pendingSyncs,
            recordCounts: recordCounts,
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.orders,
    required this.routeStops,
    required this.dueRecurring,
    required this.pendingSyncs,
    required this.recordCounts,
  });

  final List<WorkOrder> orders;
  final AsyncValue<List<WorkOrderRouteStop>> routeStops;
  final AsyncValue<List<RecurringWorkOrderCandidate>> dueRecurring;
  final int pendingSyncs;
  final _DashboardRecordCounts recordCounts;

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
        _MasterDataSection(recordCounts: recordCounts),
        const SizedBox(height: AppSpacing.lg),
        if (orders.isEmpty)
          EmptyState(
            icon: Icons.event_available,
            title: context.l10n.dashboardEmptyTodayTitle,
            message: recordCounts.hasRecords
                ? 'Stammdaten sind synchronisiert. Für heute sind keine Aufträge vorhanden.'
                : context.l10n.dashboardEmptyTodayMessage,
            action: FilledButton.icon(
              onPressed: () => recordCounts.hasRecords
                  ? context.go(AppRoutes.customers)
                  : context.go(AppRoutes.workOrders),
              icon: Icon(
                recordCounts.hasRecords ? Icons.people_outline : Icons.list_alt,
              ),
              label: Text(
                recordCounts.hasRecords
                    ? 'Kunden öffnen'
                    : context.l10n.dashboardOpenAllOrders,
              ),
            ),
          )
        else
          _NextOrderCard(order: orders.first),
        if (orders.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _RouteOptimizationCard(routeStops: routeStops),
        ],
        const SizedBox(height: AppSpacing.lg),
        _RecurringWorkOrdersCard(candidates: dueRecurring),
        const SizedBox(height: AppSpacing.lg),
        _SyncStatusCard(pendingSyncs: pendingSyncs),
        const SizedBox(height: AppSpacing.lg),
        const _QuickActions(),
      ],
    );
  }
}

class _DashboardRecordCounts {
  const _DashboardRecordCounts({
    required this.customers,
    required this.objects,
    required this.installations,
  });

  final int customers;
  final int objects;
  final int installations;

  bool get hasRecords => customers > 0 || objects > 0 || installations > 0;
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
                    ? context.l10n.offlineReadyMessage
                    : context.l10n.pendingLocalChangesMessage(pendingSyncs),
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
              label: context.l10n.ordersMetricLabel,
              value: orders.length.toString(),
              icon: Icons.event_note,
            ),
            _MetricCard(
              label: context.l10n.openSyncsMetricLabel,
              value: pendingSyncs.toString(),
              icon: Icons.sync,
            ),
            _MetricCard(
              label: context.l10n.urgentMetricLabel,
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

class _MasterDataSection extends StatelessWidget {
  const _MasterDataSection({required this.recordCounts});

  final _DashboardRecordCounts recordCounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stammdaten',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;
            return GridView.count(
              crossAxisCount: isWide ? 3 : 1,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: isWide ? 2.1 : 4.4,
              children: [
                _RecordCountCard(
                  label: context.l10n.customersTitle,
                  value: recordCounts.customers,
                  icon: Icons.people_outline,
                  route: AppRoutes.customers,
                ),
                _RecordCountCard(
                  label: context.l10n.objectsTitle,
                  value: recordCounts.objects,
                  icon: Icons.home_work_outlined,
                  route: AppRoutes.objects,
                ),
                _RecordCountCard(
                  label: context.l10n.installationsTitle,
                  value: recordCounts.installations,
                  icon: Icons.fireplace_outlined,
                  route: AppRoutes.installations,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _RecordCountCard extends StatelessWidget {
  const _RecordCountCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.route,
  });

  final String label;
  final int value;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(route),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
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
                    context.l10n.nextOrderTitle,
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
            Text('${order.orderNumber} · ${_timeRange(context, order)}'),
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
                    label: Text(context.l10n.startOrderAction),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                IconButton.outlined(
                  tooltip: context.l10n.allOrdersTooltip,
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

class _RecurringWorkOrdersCard extends ConsumerWidget {
  const _RecurringWorkOrdersCard({required this.candidates});

  final AsyncValue<List<RecurringWorkOrderCandidate>> candidates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: candidates.when(
          loading: () => const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(),
              SizedBox(height: AppSpacing.md),
            ],
          ),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.recurringWorkOrdersTitle,
            message: error.toString(),
          ),
          data: (items) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.event_repeat_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        context.l10n.recurringWorkOrdersTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    StatusBadge(
                      label: context.l10n.recurringWorkOrdersDueCount(
                        items.length,
                      ),
                      icon: Icons.repeat,
                      tone: items.isEmpty
                          ? StatusBadgeTone.success
                          : StatusBadgeTone.warning,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  items.isEmpty
                      ? context.l10n.recurringWorkOrdersEmptyMessage
                      : context.l10n.recurringWorkOrdersReadyMessage(
                          items.length,
                        ),
                ),
                if (items.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    items
                        .take(3)
                        .map(
                          (item) =>
                              '${item.installation.displayName} · ${item.object.name}',
                        )
                        .join('\n'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      onPressed: () =>
                          _generateRecurringWorkOrders(context, ref),
                      icon: const Icon(Icons.add_task_outlined),
                      label: Text(context.l10n.recurringWorkOrdersCreateAction),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RouteOptimizationCard extends StatelessWidget {
  const _RouteOptimizationCard({required this.routeStops});

  final AsyncValue<List<WorkOrderRouteStop>> routeStops;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: routeStops.when(
          loading: () => const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(),
              SizedBox(height: AppSpacing.md),
            ],
          ),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.routeOptimizationTitle,
            message: error.toString(),
          ),
          data: (stops) {
            final plan = stops.isEmpty
                ? null
                : const WorkOrderRouteOptimizer().plan(stops);
            final modeLabel = plan == null
                ? context.l10n.routeOptimizationNoStopsMessage
                : plan.optimizedByCoordinates
                ? context.l10n.routeOptimizationCoordinateMode
                : context.l10n.routeOptimizationScheduleMode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.route_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        context.l10n.routeOptimizationTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    if (plan != null)
                      StatusBadge(
                        label: modeLabel,
                        icon: plan.optimizedByCoordinates
                            ? Icons.near_me_outlined
                            : Icons.schedule_outlined,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  plan == null
                      ? modeLabel
                      : context.l10n.routeOptimizationReadyMessage(
                          plan.stops.length,
                        ),
                ),
                if (plan != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    plan.stops
                        .map(
                          (stop) =>
                              '${stop.workOrder.orderNumber} · ${stop.object.name}',
                        )
                        .join('\n'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () =>
                            context.push(AppRoutes.offlineRouteMap),
                        icon: const Icon(Icons.map_outlined),
                        label: Text(context.l10n.offlineRouteMapAction),
                      ),
                      FilledButton.icon(
                        onPressed: () => _openOptimizedRoute(context, plan),
                        icon: const Icon(Icons.open_in_new),
                        label: Text(context.l10n.routeOptimizationOpenAction),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
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
                    context.l10n.syncStatusTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    pendingSyncs == 0
                        ? context.l10n.syncStatusCleanMessage
                        : context.l10n.syncStatusWaitingMessage,
                  ),
                ],
              ),
            ),
            StatusBadge(
              label: pendingSyncs == 0
                  ? context.l10n.syncStatusSynchronized
                  : context.l10n.syncStatusOpenCount(pendingSyncs),
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
          context.l10n.quickActionsTitle,
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
                label: Text(context.l10n.searchAction),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.settings),
                icon: const Icon(Icons.settings_outlined),
                label: Text(context.l10n.settingsTitle),
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

String _timeRange(BuildContext context, WorkOrder order) {
  final start = order.scheduledStart?.toLocal();
  final end = order.scheduledEnd?.toLocal();

  if (start == null && end == null) {
    return context.l10n.noAppointment;
  }

  if (start != null && end != null) {
    return '${context.formatShortTime(start)}-${context.formatShortTime(end)}';
  }

  return context.formatShortTime(start ?? end!);
}

int _asyncListCount<T>(AsyncValue<List<T>> value) {
  return value.maybeWhen(data: (items) => items.length, orElse: () => 0);
}

Future<void> _openOptimizedRoute(
  BuildContext context,
  OptimizedWorkOrderRoute plan,
) async {
  final launched = await launchUrl(
    plan.mapsUri,
    mode: LaunchMode.externalApplication,
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.routeOptimizationOpenError)),
    );
  }
}

Future<void> _generateRecurringWorkOrders(
  BuildContext context,
  WidgetRef ref,
) async {
  try {
    final useCase = await ref.read(generateRecurringWorkOrdersProvider.future);
    final created = await useCase(DateTime.now());
    ref.invalidate(dueRecurringWorkOrdersProvider);
    ref.invalidate(todayWorkOrdersProvider);
    ref.invalidate(workOrdersProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.recurringWorkOrdersCreatedMessage(created.length),
          ),
        ),
      );
    }
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.recurringWorkOrdersErrorMessage('$error')),
        ),
      );
    }
  }
}
