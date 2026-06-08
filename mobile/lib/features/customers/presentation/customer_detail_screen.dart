import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final customerDetailProvider = FutureProvider.autoDispose
    .family<CustomerDetailData?, String>((ref, customerId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final customer = await database.customerDao.getById(customerId);
      if (customer == null || customer.deletedAt != null) {
        return null;
      }
      final objects = await database.objectDao
          .watchForCustomer(tenantId, customerId)
          .first;
      final history = await database.workOrderDao
          .watchForCustomer(tenantId, customerId)
          .first;
      return CustomerDetailData(
        customer: customer,
        objects: objects,
        history: history,
      );
    });

final class CustomerDetailData {
  const CustomerDetailData({
    required this.customer,
    required this.objects,
    required this.history,
  });

  final CustomerRow customer;
  final List<CustomerObjectRow> objects;
  final List<WorkOrderRow> history;
}

class CustomerDetailScreen extends ConsumerWidget {
  const CustomerDetailScreen({required this.customerId, super.key});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(customerDetailProvider(customerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Kunde')),
      body: SafeArea(
        child: detail.when(
          loading: () => const LoadingSkeleton(itemCount: 5),
          error: (error, stackTrace) => ErrorState(
            title: 'Kunde konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(customerDetailProvider(customerId)),
          ),
          data: (detail) {
            if (detail == null) {
              return const EmptyState(
                icon: Icons.person_off_outlined,
                title: 'Kunde nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
              );
            }
            final customer = detail.customer;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _InfoCard(
                  title: customer.displayName,
                  rows: [
                    ('Typ', customer.type),
                    ('E-Mail', customer.email ?? '-'),
                    ('Telefon', customer.phone ?? customer.mobile ?? '-'),
                    ('Rechnungsadresse', customer.billingAddress ?? '-'),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _CustomerNotesCard(
                  customerId: customer.id,
                  initialNotes: customer.notes,
                ),
                const SizedBox(height: AppSpacing.lg),
                _ObjectList(objects: detail.objects),
                const SizedBox(height: AppSpacing.lg),
                _HistoryList(history: detail.history),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CustomerNotesCard extends ConsumerStatefulWidget {
  const _CustomerNotesCard({
    required this.customerId,
    required this.initialNotes,
  });

  final String customerId;
  final String? initialNotes;

  @override
  ConsumerState<_CustomerNotesCard> createState() => _CustomerNotesCardState();
}

class _CustomerNotesCardState extends ConsumerState<_CustomerNotesCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void didUpdateWidget(covariant _CustomerNotesCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialNotes != widget.initialNotes) {
      _controller.text = widget.initialNotes ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
              'Notizen',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Kundennotizen',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Notizen speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final database = await ref.read(databaseReadyProvider.future);
    final notes = _controller.text.trim();
    await database.customerDao.updateNotesLocal(
      id: widget.customerId,
      notes: notes.isEmpty ? null : notes,
    );
    ref.invalidate(customerDetailProvider(widget.customerId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kundennotizen lokal gespeichert.')),
      );
    }
  }
}

class _ObjectList extends StatelessWidget {
  const _ObjectList({required this.objects});

  final List<CustomerObjectRow> objects;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Objekte',
      emptyIcon: Icons.home_work_outlined,
      emptyTitle: 'Keine Objekte',
      children: objects
          .map(
            (object) => ListTile(
              leading: const Icon(Icons.home_work_outlined),
              title: Text(object.name),
              subtitle: Text(
                '${object.street} ${object.houseNumber}, '
                '${object.postalCode} ${object.city}',
              ),
              onTap: () => context.push(AppRoutes.objectDetailPath(object.id)),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.history});

  final List<WorkOrderRow> history;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Auftragshistorie',
      emptyIcon: Icons.history_outlined,
      emptyTitle: 'Keine früheren Aufträge',
      children: history
          .map(
            (order) => ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(order.title),
              subtitle: Text(
                '${order.orderNumber} · ${_formatDate(order.scheduledStart)}',
              ),
              trailing: Text(order.status),
              onTap: () =>
                  context.push(AppRoutes.workOrderDetailPath(order.id)),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 128,
                      child: Text(
                        row.$1,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Expanded(child: Text(row.$2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.children,
  });

  final String title;
  final IconData emptyIcon;
  final String emptyTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
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
            if (children.isEmpty)
              EmptyState(icon: emptyIcon, title: emptyTitle, message: '')
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

String _formatDate(String? value) {
  final date = value == null ? null : DateTime.tryParse(value)?.toLocal();
  if (date == null) {
    return 'ohne Termin';
  }
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}
