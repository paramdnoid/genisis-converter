import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_customer_repository.dart';
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/customer_detail.dart';
import '../../../domain/repositories/customer_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final customerRepositoryProvider = FutureProvider<CustomerRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftCustomerRepository(database: database, tenantId: tenantId);
});

final customersProvider = StreamProvider.autoDispose<List<Customer>>((
  ref,
) async* {
  final repository = await ref.watch(customerRepositoryProvider.future);
  yield* repository.watchAll();
});

final customerDetailProvider = FutureProvider.autoDispose
    .family<CustomerDetail?, String>((ref, customerId) async {
      final repository = await ref.watch(customerRepositoryProvider.future);
      return repository.getDetail(customerId);
    });
