import 'dart:async';

import '../../domain/entities/customer.dart';
import '../../domain/entities/customer_object.dart';
import '../../domain/entities/installation.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/entities/work_order_detail.dart';
import '../../domain/enums/work_order_status.dart';
import '../../domain/repositories/work_order_repository.dart';
import '../db/app_database.dart';

final class DriftWorkOrderRepository implements WorkOrderRepository {
  const DriftWorkOrderRepository({
    required this.database,
    required this.tenantId,
    required this.userId,
  });

  final AppDatabase database;
  final String tenantId;
  final String userId;

  @override
  Stream<List<WorkOrder>> watchAll() {
    return database.workOrderDao.watchActive(tenantId).map(_mapRows);
  }

  @override
  Stream<List<WorkOrder>> watchToday(DateTime day) {
    return database.workOrderDao.watchToday(tenantId, day).map(_mapRows);
  }

  @override
  Stream<WorkOrderDetail?> watchDetail(String id) {
    late StreamSubscription<WorkOrderDetailHeaderRow?> headerSubscription;
    StreamSubscription<List<InstallationRow>>? installationSubscription;

    final controller = StreamController<WorkOrderDetail?>();
    WorkOrderDetailHeaderRow? header;
    List<Installation> installations = const [];

    void emit() {
      final currentHeader = header;
      if (currentHeader == null) {
        controller.add(null);
        return;
      }

      controller.add(
        WorkOrderDetail(
          workOrder: _mapRow(currentHeader.workOrder),
          customer: _mapCustomerRow(currentHeader.customer),
          object: _mapObjectRow(currentHeader.object),
          installations: installations,
        ),
      );
    }

    controller.onListen = () {
      headerSubscription = database.workOrderDao
          .watchDetailHeader(tenantId, id)
          .listen((nextHeader) {
            header = nextHeader;
            installationSubscription?.cancel();
            installations = const [];

            if (nextHeader == null) {
              emit();
              return;
            }

            installationSubscription = database.installationDao
                .watchForObject(tenantId, nextHeader.object.id)
                .listen((rows) {
                  installations = rows
                      .map(_mapInstallationRow)
                      .toList(growable: false);
                  emit();
                }, onError: controller.addError);
          }, onError: controller.addError);
    };

    controller.onCancel = () async {
      await installationSubscription?.cancel();
      await headerSubscription.cancel();
    };

    return controller.stream;
  }

  @override
  Future<void> startWorkOrder(String id) async {
    await database.workOrderDao.startLocal(id: id, userId: userId);
  }

  @override
  Future<void> pauseWorkOrder(String id) async {
    await database.workOrderDao.pauseLocal(id);
  }

  @override
  Future<void> resumeWorkOrder(String id) async {
    await database.workOrderDao.resumeLocal(id: id, userId: userId);
  }

  @override
  Future<void> completeWorkOrder(String id, {String? notes}) async {
    await database.workOrderDao.completeLocal(id, notes: notes);
  }
}

List<WorkOrder> _mapRows(List<WorkOrderRow> rows) {
  return rows.map(_mapRow).toList(growable: false);
}

WorkOrder _mapRow(WorkOrderRow row) {
  return WorkOrder(
    id: row.id,
    tenantId: row.tenantId,
    orderNumber: row.orderNumber,
    title: row.title,
    type: row.type,
    status: WorkOrderStatus.parse(row.status),
    priority: WorkOrderPriority.parse(row.priority),
    version: row.version,
    syncStatus: row.syncStatus,
    description: row.description,
    customerId: row.customerId,
    objectId: row.objectId,
    assignedUserId: row.assignedUserId,
    scheduledStart: _parseDate(row.scheduledStart),
    scheduledEnd: _parseDate(row.scheduledEnd),
    actualStart: _parseDate(row.actualStart),
    actualEnd: _parseDate(row.actualEnd),
    completionNotes: row.completionNotes,
  );
}

DateTime? _parseDate(String? value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value);
}

Customer _mapCustomerRow(CustomerRow row) {
  return Customer(
    id: row.id,
    tenantId: row.tenantId,
    type: row.type,
    displayName: row.displayName,
    firstName: row.firstName,
    lastName: row.lastName,
    companyName: row.companyName,
    email: row.email,
    phone: row.phone,
    mobile: row.mobile,
    billingAddress: row.billingAddress,
    notes: row.notes,
  );
}

CustomerObject _mapObjectRow(CustomerObjectRow row) {
  return CustomerObject(
    id: row.id,
    tenantId: row.tenantId,
    customerId: row.customerId,
    name: row.name,
    street: row.street,
    houseNumber: row.houseNumber,
    postalCode: row.postalCode,
    city: row.city,
    country: row.country,
    latitude: row.latitude,
    longitude: row.longitude,
    accessNotes: row.accessNotes,
    safetyNotes: row.safetyNotes,
    objectNotes: row.objectNotes,
  );
}

Installation _mapInstallationRow(InstallationRow row) {
  return Installation(
    id: row.id,
    tenantId: row.tenantId,
    objectId: row.objectId,
    type: row.type,
    manufacturer: row.manufacturer,
    model: row.model,
    serialNumber: row.serialNumber,
    fuelType: row.fuelType,
    installationYear: row.installationYear,
    locationDescription: row.locationDescription,
    intervalMonths: row.intervalMonths,
    lastServiceDate: _parseDate(row.lastServiceDate),
    nextServiceDate: _parseDate(row.nextServiceDate),
    notes: row.notes,
  );
}
