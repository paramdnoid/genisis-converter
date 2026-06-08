import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/sync/sync_providers.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/enums/work_order_status.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/work_order_providers.dart';

class WorkOrderListScreen extends ConsumerStatefulWidget {
  const WorkOrderListScreen({super.key});

  @override
  ConsumerState<WorkOrderListScreen> createState() =>
      _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends ConsumerState<WorkOrderListScreen> {
  final _searchController = TextEditingController();
  WorkOrderStatus? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workOrders = ref.watch(workOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.workOrdersTitle)),
      body: SafeArea(
        child: workOrders.when(
          loading: () => const LoadingSkeleton(),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.workOrdersLoadErrorTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrdersProvider),
          ),
          data: (orders) {
            final filteredOrders = _filterOrders(orders);

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(syncNowProvider);
                await ref.read(syncNowProvider.future);
                ref.invalidate(workOrdersProvider);
                await ref.read(workOrdersProvider.future);
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                children: [
                  TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: context.l10n.workOrdersSearchLabel,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _StatusFilterBar(
                    selectedStatus: _statusFilter,
                    onChanged: (status) {
                      setState(() => _statusFilter = status);
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (filteredOrders.isEmpty)
                    EmptyState(
                      icon: Icons.assignment_outlined,
                      title: context.l10n.workOrdersEmptyFilteredTitle,
                      message: context.l10n.workOrdersEmptyFilteredMessage,
                      action: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _statusFilter = null;
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                        label: Text(context.l10n.resetFilterAction),
                      ),
                    )
                  else
                    ...filteredOrders.map(
                      (order) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _WorkOrderCard(order: order),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<WorkOrder> _filterOrders(List<WorkOrder> orders) {
    final query = _searchController.text.trim().toLowerCase();

    return orders
        .where((order) {
          final matchesStatus =
              _statusFilter == null || order.status == _statusFilter;
          final matchesQuery =
              query.isEmpty ||
              order.title.toLowerCase().contains(query) ||
              order.orderNumber.toLowerCase().contains(query) ||
              (order.description?.toLowerCase().contains(query) ?? false);

          return matchesStatus && matchesQuery;
        })
        .toList(growable: false);
  }
}

class _StatusFilterBar extends StatelessWidget {
  const _StatusFilterBar({
    required this.selectedStatus,
    required this.onChanged,
  });

  final WorkOrderStatus? selectedStatus;
  final ValueChanged<WorkOrderStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    const filters = [
      null,
      WorkOrderStatus.scheduled,
      WorkOrderStatus.inProgress,
      WorkOrderStatus.completed,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            FilterChip(
              selected: selectedStatus == filter,
              onSelected: (_) => onChanged(filter),
              label: Text(filter?.label ?? context.l10n.allFilterLabel),
              avatar: Icon(
                filter == null ? Icons.list_alt : Icons.circle,
                size: 16,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _WorkOrderCard extends ConsumerWidget {
  const _WorkOrderCard({required this.order});

  final WorkOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(AppRoutes.workOrderDetailPath(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      order.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _WorkOrderStatusBadge(order: order),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${order.orderNumber} · ${_formattedAppointment(context, order)}',
              ),
              if (order.description != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(order.description!),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  StatusBadge(
                    label: order.priority.label,
                    icon: Icons.flag_outlined,
                    tone:
                        order.priority == WorkOrderPriority.urgent ||
                            order.priority == WorkOrderPriority.high
                        ? StatusBadgeTone.warning
                        : StatusBadgeTone.neutral,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  if (order.isDirty)
                    StatusBadge(
                      label: context.l10n.locallyChangedStatus,
                      icon: Icons.cloud_upload_outlined,
                      tone: StatusBadgeTone.warning,
                    ),
                  const Spacer(),
                  IconButton.outlined(
                    tooltip: context.l10n.startOrderAction,
                    onPressed: order.status.canStart
                        ? () => _startOrder(ref, order.id)
                        : null,
                    icon: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton.outlined(
                    tooltip: context.l10n.completeOrderTooltip,
                    onPressed: order.status.canComplete
                        ? () => context.push(
                            AppRoutes.workOrderCompletePath(order.id),
                          )
                        : null,
                    icon: const Icon(Icons.task_alt),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startOrder(WidgetRef ref, String id) async {
    final startWorkOrder = await ref.read(startWorkOrderProvider.future);
    await startWorkOrder(id);
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

String _formattedAppointment(BuildContext context, WorkOrder order) {
  final start = order.scheduledStart?.toLocal();
  final end = order.scheduledEnd?.toLocal();

  if (start == null) {
    return context.l10n.noAppointment;
  }

  final date = context.formatShortDate(start);
  final time = context.formatShortTime(start);
  final endTime = end == null ? null : context.formatShortTime(end);

  return endTime == null ? '$date · $time' : '$date · $time-$endTime';
}
