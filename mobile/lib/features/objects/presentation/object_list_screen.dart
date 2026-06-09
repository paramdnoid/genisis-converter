import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../domain/entities/customer_object.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/customer_object_providers.dart';

class ObjectListScreen extends ConsumerStatefulWidget {
  const ObjectListScreen({super.key});

  @override
  ConsumerState<ObjectListScreen> createState() => _ObjectListScreenState();
}

class _ObjectListScreenState extends ConsumerState<ObjectListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final objects = ref.watch(customerObjectsProvider(_query));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.objectsTitle)),
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
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                labelText: 'Objekte suchen',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            objects.when(
              loading: () => const LoadingSkeleton(itemCount: 5),
              error: (error, stackTrace) => ErrorState(
                title: context.l10n.objectsEmptyTitle,
                message: error.toString(),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.home_work_outlined,
                    title: context.l10n.objectsEmptyTitle,
                    message: 'Objektdaten werden nach dem Sync lokal sichtbar.',
                  );
                }
                return Column(
                  children: items
                      .map(
                        (object) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.home_work_outlined),
                              title: Text(object.name),
                              subtitle: Text(_objectAddress(object)),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push(
                                AppRoutes.objectDetailPath(object.id),
                              ),
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

String _objectAddress(CustomerObject object) {
  return [
    '${object.street} ${object.houseNumber}'.trim(),
    '${object.postalCode} ${object.city}'.trim(),
  ].where((part) => part.isNotEmpty).join(', ');
}
