import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/enums/work_order_status.dart';
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
      appBar: AppBar(title: const Text('Aufträge')),
      body: SafeArea(
        child: workOrders.when(
          loading: () => const LoadingSkeleton(),
          error: (error, stackTrace) => ErrorState(
            title: 'Aufträge konnten nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(workOrdersProvider),
          ),
          data: (orders) {
            final filteredOrders = _filterOrders(orders);

            return RefreshIndicator(
              onRefresh: () async {
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
                    decoration: const InputDecoration(
                      labelText: 'Aufträge suchen',
                      prefixIcon: Icon(Icons.search),
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
                      title: 'Keine passenden Aufträge',
                      message: 'Passe Suche oder Statusfilter an.',
                      action: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _statusFilter = null;
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Filter zurücksetzen'),
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
              label: Text(filter?.label ?? 'Alle'),
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
              Text('${order.orderNumber} · ${_formattedAppointment(order)}'),
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
                    const StatusBadge(
                      label: 'Lokal geändert',
                      icon: Icons.cloud_upload_outlined,
                      tone: StatusBadgeTone.warning,
                    ),
                  const Spacer(),
                  IconButton.outlined(
                    tooltip: 'Starten',
                    onPressed: order.status.canStart
                        ? () => _startOrder(ref, order.id)
                        : null,
                    icon: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton.outlined(
                    tooltip: 'Abschließen',
                    onPressed: order.status.canComplete
                        ? () => _completeOrder(ref, order.id)
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

  Future<void> _completeOrder(WidgetRef ref, String id) async {
    final completeWorkOrder = await ref.read(completeWorkOrderProvider.future);
    await completeWorkOrder(id);
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

String _formattedAppointment(WorkOrder order) {
  final start = order.scheduledStart?.toLocal();
  final end = order.scheduledEnd?.toLocal();

  if (start == null) {
    return 'ohne Termin';
  }

  final date = DateFormat('dd.MM.yyyy').format(start);
  final time = DateFormat('HH:mm').format(start);
  final endTime = end == null ? null : DateFormat('HH:mm').format(end);

  return endTime == null ? '$date · $time' : '$date · $time-$endTime';
}
