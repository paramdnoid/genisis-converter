import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/customer.dart';
import 'package:kaminfeger_mobile/domain/entities/customer_object.dart';
import 'package:kaminfeger_mobile/domain/entities/installation.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order_detail.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';
import 'package:kaminfeger_mobile/domain/use_cases/completion_validator.dart';

void main() {
  test(
    'allows completion only for started orders with required detail data',
    () {
      const validator = CompletionValidator();

      final invalid = validator.validate(
        _detail(status: WorkOrderStatus.scheduled),
      );
      final valid = validator.validate(
        _detail(
          status: WorkOrderStatus.inProgress,
          actualStart: DateTime.utc(2026),
          installations: const [
            Installation(
              id: 'installation-1',
              tenantId: 'tenant-1',
              objectId: 'object-1',
              type: 'fireplace',
            ),
          ],
        ),
      );

      expect(invalid.canComplete, isFalse);
      expect(invalid.missingItems, contains('Auftrag muss gestartet sein.'));
      expect(valid.canComplete, isTrue);
    },
  );
}

WorkOrderDetail _detail({
  required WorkOrderStatus status,
  DateTime? actualStart,
  List<Installation> installations = const [],
}) {
  return WorkOrderDetail(
    workOrder: WorkOrder(
      id: 'order-1',
      tenantId: 'tenant-1',
      orderNumber: 'WO-1',
      title: 'Kontrolle',
      type: 'inspection',
      status: status,
      priority: WorkOrderPriority.normal,
      version: 1,
      syncStatus: 'synced',
      actualStart: actualStart,
    ),
    customer: const Customer(
      id: 'customer-1',
      tenantId: 'tenant-1',
      type: 'private',
      displayName: 'Familie Keller',
    ),
    object: const CustomerObject(
      id: 'object-1',
      tenantId: 'tenant-1',
      customerId: 'customer-1',
      name: 'Haus',
      street: 'Im Ried',
      houseNumber: '7',
      postalCode: '8610',
      city: 'Uster',
      country: 'CH',
    ),
    installations: installations,
  );
}
