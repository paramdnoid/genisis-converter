import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';

final customerDetailProvider = FutureProvider.autoDispose
    .family<CustomerRow?, String>((ref, customerId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      return (database.select(
        database.customers,
      )..where((table) => table.id.equals(customerId))).getSingleOrNull();
    });

class CustomerDetailScreen extends ConsumerWidget {
  const CustomerDetailScreen({required this.customerId, super.key});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerDetailProvider(customerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Kunde')),
      body: SafeArea(
        child: customer.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: 'Kunde konnte nicht geladen werden',
            message: error.toString(),
          ),
          data: (customer) {
            if (customer == null) {
              return const EmptyState(
                icon: Icons.person_off_outlined,
                title: 'Kunde nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
              );
            }
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
                    ('Notizen', customer.notes ?? '-'),
                  ],
                ),
              ],
            );
          },
        ),
      ),
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
