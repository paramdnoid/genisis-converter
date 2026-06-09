import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_customer_object_repository.dart';
import '../../../domain/entities/customer_object.dart';
import '../../../domain/entities/customer_object_detail.dart';
import '../../../domain/repositories/customer_object_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final customerObjectRepositoryProvider =
    FutureProvider<CustomerObjectRepository>((ref) async {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      return DriftCustomerObjectRepository(
        database: database,
        tenantId: tenantId,
      );
    });

final customerObjectDetailProvider = FutureProvider.autoDispose
    .family<CustomerObjectDetail?, String>((ref, objectId) async {
      final repository = await ref.watch(
        customerObjectRepositoryProvider.future,
      );
      return repository.getDetail(objectId);
    });

final customerObjectsProvider = StreamProvider.autoDispose
    .family<List<CustomerObject>, String>((ref, query) async* {
      final repository = await ref.watch(
        customerObjectRepositoryProvider.future,
      );
      final normalized = query.trim().toLowerCase();

      await for (final objects in repository.watchAll()) {
        if (normalized.isEmpty) {
          yield objects;
          continue;
        }

        yield objects
            .where((object) {
              final haystack = [
                object.name,
                object.street,
                object.houseNumber,
                object.postalCode,
                object.city,
              ].join(' ').toLowerCase();
              return haystack.contains(normalized);
            })
            .toList(growable: false);
      }
    });
