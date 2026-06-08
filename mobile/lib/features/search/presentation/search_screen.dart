import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/db/database_providers.dart';
import '../../../l10n/app_localizations_x.dart';
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
              groupKey: SearchResultGroup.orders,
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
              groupKey: SearchResultGroup.customers,
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
              groupKey: SearchResultGroup.objects,
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
              groupKey: SearchResultGroup.installations,
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
    required this.groupKey,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final SearchResultGroup groupKey;
  final String title;
  final String subtitle;
  final String route;
}

enum SearchResultGroup { orders, customers, objects, installations }

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _query = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider(_query));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.searchTitle)),
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
              onChanged: _scheduleSearch,
              decoration: InputDecoration(
                labelText: context.l10n.searchFieldLabel,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            results.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off,
                    title: context.l10n.searchNoResultsTitle,
                    message: context.l10n.searchNoResultsMessage,
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
                                '${_groupLabel(context, item.groupKey)} · ${item.subtitle}',
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

  void _scheduleSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() => _query = value);
      }
    });
  }
}

String _groupLabel(BuildContext context, SearchResultGroup group) {
  return switch (group) {
    SearchResultGroup.orders => context.l10n.searchGroupOrders,
    SearchResultGroup.customers => context.l10n.searchGroupCustomers,
    SearchResultGroup.objects => context.l10n.searchGroupObjects,
    SearchResultGroup.installations => context.l10n.searchGroupInstallations,
  };
}
