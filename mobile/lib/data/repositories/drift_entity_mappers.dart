import '../../domain/entities/customer.dart';
import '../../domain/entities/customer_object.dart';
import '../../domain/entities/installation.dart';
import '../../domain/entities/photo_attachment.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/enums/work_order_status.dart';
import '../db/app_database.dart';

Customer mapCustomerRow(CustomerRow row) {
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

CustomerObject mapCustomerObjectRow(CustomerObjectRow row) {
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

Installation mapInstallationRow(InstallationRow row) {
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
    lastServiceDate: parseDate(row.lastServiceDate),
    nextServiceDate: parseDate(row.nextServiceDate),
    notes: row.notes,
  );
}

WorkOrder mapWorkOrderRow(WorkOrderRow row) {
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
    scheduledStart: parseDate(row.scheduledStart),
    scheduledEnd: parseDate(row.scheduledEnd),
    actualStart: parseDate(row.actualStart),
    actualEnd: parseDate(row.actualEnd),
    completionNotes: row.completionNotes,
  );
}

PhotoAttachment mapPhotoRow(PhotoRow row) {
  return PhotoAttachment(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    objectId: row.objectId,
    installationId: row.installationId,
    defectId: row.defectId,
    localPath: row.localPath,
    remoteUrl: row.remoteUrl,
    fileName: row.fileName,
    mimeType: row.mimeType,
    sizeBytes: row.sizeBytes,
    caption: row.caption,
    takenAt: DateTime.parse(row.takenAt),
    uploadStatus: row.uploadStatus,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}

DateTime? parseDate(String? value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value);
}
