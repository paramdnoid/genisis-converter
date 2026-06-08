import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/customer_providers.dart';

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.customersTitle)),
      body: SafeArea(
        child: customers.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: context.l10n.customersLoadErrorTitle,
            message: error.toString(),
            onRetry: () => ref.invalidate(customersProvider),
          ),
          data: (customers) {
            if (customers.isEmpty) {
              return EmptyState(
                icon: Icons.people_outline,
                title: context.l10n.customersEmptyTitle,
                message: context.l10n.customersEmptyMessage,
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
