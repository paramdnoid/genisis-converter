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

final customersProvider = StreamProvider.autoDispose<List<CustomerRow>>((
  ref,
) async* {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  yield* database.customerDao.watchActive(tenantId);
});

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kunden')),
      body: SafeArea(
        child: customers.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Kunden konnten nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(customersProvider),
          ),
          data: (customers) {
            if (customers.isEmpty) {
              return const EmptyState(
                icon: Icons.people_outline,
                title: 'Keine Kunden',
                message: 'Kundendaten werden nach dem Sync lokal sichtbar.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(customer.displayName),
                      subtitle: Text(customer.email ?? customer.phone ?? ''),
                      onTap: () => context.push(
                        AppRoutes.customerDetailPath(customer.id),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
