import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/db/database_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final searchResultsProvider = FutureProvider.autoDispose
    .family<List<SearchResult>, String>((ref, rawQuery) async {
      final query = rawQuery.trim().toLowerCase();
      if (query.length < 2) {
        return const [];
      }

      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final results = <SearchResult>[];

      final orders = await database.workOrderDao.watchActive(tenantId).first;
      for (final order in orders) {
        final haystack = [
          order.orderNumber,
          order.title,
          order.description,
          order.status,
        ].whereType<String>().join(' ').toLowerCase();
        if (haystack.contains(query)) {
          results.add(
            SearchResult(
              group: 'Aufträge',
              title: order.title,
              subtitle: order.orderNumber,
              route: AppRoutes.workOrderDetailPath(order.id),
            ),
          );
        }
      }

      final customers = await database.customerDao.watchActive(tenantId).first;
      for (final customer in customers) {
        final haystack = [
          customer.displayName,
          customer.email,
          customer.phone,
          customer.mobile,
        ].whereType<String>().join(' ').toLowerCase();
        if (haystack.contains(query)) {
          results.add(
            SearchResult(
              group: 'Kunden',
              title: customer.displayName,
              subtitle: customer.email ?? customer.phone ?? '',
              route: AppRoutes.customerDetailPath(customer.id),
            ),
          );
        }
      }

      final objects = await database.objectDao.watchActive(tenantId).first;
      for (final object in objects) {
        final haystack = [
          object.name,
          object.street,
          object.houseNumber,
          object.postalCode,
          object.city,
        ].join(' ').toLowerCase();
        if (haystack.contains(query)) {
          results.add(
            SearchResult(
              group: 'Objekte',
              title: object.name,
              subtitle:
                  '${object.street} ${object.houseNumber}, ${object.postalCode} ${object.city}',
              route: AppRoutes.objectDetailPath(object.id),
            ),
          );
        }
      }

      final installations = await database.installationDao
          .watchActive(tenantId)
          .first;
      for (final installation in installations) {
        final haystack = [
          installation.type,
          installation.manufacturer,
          installation.model,
          installation.serialNumber,
          installation.locationDescription,
        ].whereType<String>().join(' ').toLowerCase();
        if (haystack.contains(query)) {
          results.add(
            SearchResult(
              group: 'Anlagen',
              title: [
                installation.manufacturer,
                installation.model,
              ].whereType<String>().join(' '),
              subtitle: installation.serialNumber ?? installation.type,
              route: AppRoutes.installationDetailPath(installation.id),
            ),
          );
        }
      }

      return results;
    });

final class SearchResult {
  const SearchResult({
    required this.group,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final String group;
  final String title;
  final String subtitle;
  final String route;
}

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider(_query));

    return Scaffold(
      appBar: AppBar(title: const Text('Suche')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            TextField(
              autofocus: true,
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                labelText: 'Auftrag, Kunde, Adresse oder Anlage suchen',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            results.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.search_off,
                    title: 'Keine Treffer',
                    message: 'Mindestens zwei Zeichen eingeben.',
                  );
                }
                return Column(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.search),
                              title: Text(item.title),
                              subtitle: Text(
                                '${item.group} · ${item.subtitle}',
                              ),
                              onTap: () => context.push(item.route),
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
