import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

const _uuid = Uuid();

String _utcNowIso() => DateTime.now().toUtc().toIso8601String();

int _minutesBetweenIso(String startIso, String endIso) {
  final start = DateTime.parse(startIso);
  final end = DateTime.parse(endIso);
  final minutes = end.difference(start).inMinutes;
  return minutes < 0 ? 0 : minutes;
}

abstract final class DevelopmentSeed {
  static const tenantId = '11111111-1111-4111-8111-111111111111';
  static const technicianUserId = '22222222-2222-4222-8222-222222222222';
  static const customerId = '33333333-3333-4333-8333-333333333333';
  static const objectId = '44444444-4444-4444-8444-444444444444';
  static const installationId = '55555555-5555-4555-8555-555555555555';
  static const materialCleaningId = 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb';
  static const workOrderInspectionId = '66666666-6666-4666-8666-666666666666';
  static const workOrderCleaningId = '77777777-7777-4777-8777-777777777777';
  static const tariffCatalogInspectionId =
      'cccccccc-cccc-4ccc-8ccc-cccccccccccc';
  static const tariffCatalogCleaningId = 'dddddddd-dddd-4ddd-8ddd-dddddddddddd';
  static const objectTariffInspectionId =
      'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee';
  static const objectTariffCleaningId = 'ffffffff-ffff-4fff-8fff-ffffffffffff';
  static const checklistTemplateId = '99999999-9999-4999-8999-999999999999';
  static const reportTemplateId = '12121212-1212-4212-8212-121212121212';
}

mixin SyncColumns on Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text().named('tenant_id')();
  TextColumn get createdAt =>
      text().named('created_at').clientDefault(_utcNowIso)();
  TextColumn get updatedAt =>
      text().named('updated_at').clientDefault(_utcNowIso)();
  TextColumn get deletedAt => text().nullable().named('deleted_at')();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus =>
      text().named('sync_status').withDefault(const Constant('synced'))();
  TextColumn get lastSyncedAt => text().nullable().named('last_synced_at')();
}

@DataClassName('TenantRow')
class Tenants extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get postalCode => text().named('postal_code')();
  TextColumn get city => text()();
  TextColumn get country => text()();
  TextColumn get phone => text()();
  TextColumn get email => text()();
  TextColumn get logoFileId => text().nullable().named('logo_file_id')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('UserRow')
class Users extends Table with SyncColumns {
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get email => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text()();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CustomerRow')
class Customers extends Table with SyncColumns {
  TextColumn get type => text()();
  TextColumn get displayName => text().named('display_name')();
  TextColumn get firstName => text().nullable().named('first_name')();
  TextColumn get lastName => text().nullable().named('last_name')();
  TextColumn get companyName => text().nullable().named('company_name')();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get billingAddress => text().nullable().named('billing_address')();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CustomerObjectRow')
class CustomerObjects extends Table with SyncColumns {
  @override
  String get tableName => 'objects';

  TextColumn get customerId => text().named('customer_id')();
  TextColumn get name => text()();
  TextColumn get street => text()();
  TextColumn get houseNumber => text().named('house_number')();
  TextColumn get postalCode => text().named('postal_code')();
  TextColumn get city => text()();
  TextColumn get country => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get accessNotes => text().nullable().named('access_notes')();
  TextColumn get safetyNotes => text().nullable().named('safety_notes')();
  TextColumn get objectNotes => text().nullable().named('object_notes')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('InstallationRow')
class Installations extends Table with SyncColumns {
  TextColumn get objectId => text().named('object_id')();
  TextColumn get type => text()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get serialNumber => text().nullable().named('serial_number')();
  TextColumn get fuelType => text().nullable().named('fuel_type')();
  IntColumn get installationYear =>
      integer().nullable().named('installation_year')();
  TextColumn get locationDescription =>
      text().nullable().named('location_description')();
  IntColumn get intervalMonths =>
      integer().nullable().named('interval_months')();
  TextColumn get lastServiceDate =>
      text().nullable().named('last_service_date')();
  TextColumn get nextServiceDate =>
      text().nullable().named('next_service_date')();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('WorkOrderRow')
class WorkOrders extends Table with SyncColumns {
  TextColumn get customerId => text().named('customer_id')();
  TextColumn get objectId => text().named('object_id')();
  TextColumn get assignedUserId =>
      text().nullable().named('assigned_user_id')();
  TextColumn get orderNumber => text().named('order_number')();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text()();
  TextColumn get status => text()();
  TextColumn get priority => text()();
  TextColumn get scheduledStart => text().nullable().named('scheduled_start')();
  TextColumn get scheduledEnd => text().nullable().named('scheduled_end')();
  TextColumn get actualStart => text().nullable().named('actual_start')();
  TextColumn get actualEnd => text().nullable().named('actual_end')();
  TextColumn get customerSignatureFileId =>
      text().nullable().named('customer_signature_file_id')();
  TextColumn get reportFileId => text().nullable().named('report_file_id')();
  TextColumn get completionNotes =>
      text().nullable().named('completion_notes')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('WorkOrderInstallationRow')
class WorkOrderInstallations extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get installationId => text().named('installation_id')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChecklistTemplateRow')
class ChecklistTemplates extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get versionNumber => integer().named('version_number')();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChecklistTemplateItemRow')
class ChecklistTemplateItems extends Table with SyncColumns {
  TextColumn get templateId => text().named('template_id')();
  IntColumn get position => integer()();
  TextColumn get label => text()();
  TextColumn get helpText => text().nullable().named('help_text')();
  TextColumn get answerType => text().named('answer_type')();
  BoolColumn get required =>
      boolean().named('required').withDefault(const Constant(false))();
  TextColumn get optionsJson => text().nullable().named('options_json')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChecklistAnswerRow')
class ChecklistAnswers extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get templateItemId => text().named('template_item_id')();
  TextColumn get answerValue => text().nullable().named('answer_value')();
  TextColumn get comment => text().nullable()();
  BoolColumn get isOk => boolean().nullable().named('is_ok')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeasurementRow')
class Measurements extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get installationId => text().nullable().named('installation_id')();
  TextColumn get measurementType => text().named('measurement_type')();
  RealColumn get value => real()();
  TextColumn get unit => text()();
  TextColumn get measuredAt => text().named('measured_at')();
  TextColumn get deviceName => text().nullable().named('device_name')();
  TextColumn get deviceSerial => text().nullable().named('device_serial')();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DefectRow')
class Defects extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get installationId => text().nullable().named('installation_id')();
  TextColumn get severity => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get recommendedAction =>
      text().nullable().named('recommended_action')();
  TextColumn get dueDate => text().nullable().named('due_date')();
  BoolColumn get resolved => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PhotoRow')
class Photos extends Table with SyncColumns {
  TextColumn get workOrderId => text().nullable().named('work_order_id')();
  TextColumn get objectId => text().nullable().named('object_id')();
  TextColumn get installationId => text().nullable().named('installation_id')();
  TextColumn get defectId => text().nullable().named('defect_id')();
  TextColumn get localPath => text().named('local_path')();
  TextColumn get remoteUrl => text().nullable().named('remote_url')();
  TextColumn get fileName => text().named('file_name')();
  TextColumn get mimeType => text().named('mime_type')();
  IntColumn get sizeBytes => integer().named('size_bytes')();
  TextColumn get caption => text().nullable()();
  TextColumn get takenAt => text().named('taken_at')();
  TextColumn get uploadStatus => text().named('upload_status')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TimeEntryRow')
class TimeEntries extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get userId => text().named('user_id')();
  TextColumn get type => text()();
  TextColumn get startTime => text().named('start_time')();
  TextColumn get endTime => text().nullable().named('end_time')();
  IntColumn get durationMinutes =>
      integer().nullable().named('duration_minutes')();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MaterialRow')
class Materials extends Table with SyncColumns {
  TextColumn get sku => text().nullable()();
  TextColumn get name => text()();
  TextColumn get unit => text()();
  RealColumn get defaultPrice => real().nullable().named('default_price')();
  RealColumn get stockQuantity => real().nullable().named('stock_quantity')();
  RealColumn get minStockQuantity =>
      real().nullable().named('min_stock_quantity')();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('WorkOrderMaterialRow')
class WorkOrderMaterials extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get materialId => text().nullable().named('material_id')();
  TextColumn get name => text()();
  RealColumn get quantity => real()();
  TextColumn get unit => text()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TariffCatalogItemRow')
class TariffCatalogItems extends Table with SyncColumns {
  TextColumn get tariffSystem => text().named('tariff_system')();
  TextColumn get code => text()();
  TextColumn get description => text()();
  RealColumn get defaultPrice => real().nullable().named('default_price')();
  TextColumn get taxCategory => text().nullable().named('tax_category')();
  RealColumn get taxPoints => real().nullable().named('tax_points')();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ObjectTariffAssignmentRow')
class ObjectTariffAssignments extends Table with SyncColumns {
  TextColumn get objectId => text().nullable().named('object_id')();
  TextColumn get tariffCatalogItemId =>
      text().nullable().named('tariff_catalog_item_id')();
  TextColumn get tariffSystem => text().named('tariff_system')();
  TextColumn get code => text().nullable()();
  TextColumn get description => text()();
  IntColumn get position => integer().nullable()();
  RealColumn get defaultQuantity =>
      real().nullable().named('default_quantity')();
  TextColumn get unit => text().nullable()();
  RealColumn get priceOverride => real().nullable().named('price_override')();
  RealColumn get taxPoints => real().nullable().named('tax_points')();
  TextColumn get billingCode => text().nullable().named('billing_code')();
  TextColumn get intervalCode => text().nullable().named('interval_code')();
  TextColumn get flag13 => text().nullable().named('flag_13')();
  TextColumn get flag14 => text().nullable().named('flag_14')();
  TextColumn get flag15 => text().nullable().named('flag_15')();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('WorkOrderServiceLineRow')
class WorkOrderServiceLines extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get objectTariffAssignmentId =>
      text().nullable().named('object_tariff_assignment_id')();
  TextColumn get tariffCatalogItemId =>
      text().nullable().named('tariff_catalog_item_id')();
  TextColumn get installationId => text().nullable().named('installation_id')();
  TextColumn get code => text().nullable()();
  TextColumn get name => text()();
  RealColumn get quantity => real()();
  TextColumn get unit => text()();
  RealColumn get unitPrice => real().nullable().named('unit_price')();
  RealColumn get totalPrice => real().nullable().named('total_price')();
  RealColumn get taxPoints => real().nullable().named('tax_points')();
  TextColumn get status => text().withDefault(const Constant('performed'))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LegacyImportRecordRow')
class LegacyImportRecords extends Table with SyncColumns {
  TextColumn get batchId => text().named('batch_id')();
  TextColumn get sourceSystem => text().named('source_system')();
  TextColumn get sourceFile => text().named('source_file')();
  TextColumn get sourceTable => text().named('source_table')();
  TextColumn get sourceKey => text().named('source_key')();
  TextColumn get rowHash => text().named('row_hash')();
  IntColumn get rowIndex => integer().nullable().named('row_index')();
  TextColumn get recordType =>
      text().named('record_type').withDefault(const Constant('row'))();
  TextColumn get mappedEntityType =>
      text().nullable().named('mapped_entity_type')();
  TextColumn get mappedEntityId =>
      text().nullable().named('mapped_entity_id')();
  TextColumn get payloadJson => text().named('payload_json')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ReportRow')
class Reports extends Table with SyncColumns {
  TextColumn get workOrderId => text().named('work_order_id')();
  TextColumn get reportNumber => text().named('report_number')();
  TextColumn get status => text()();
  TextColumn get pdfLocalPath => text().nullable().named('pdf_local_path')();
  TextColumn get pdfRemoteUrl => text().nullable().named('pdf_remote_url')();
  TextColumn get generatedAt => text().nullable().named('generated_at')();
  TextColumn get signedAt => text().nullable().named('signed_at')();
  TextColumn get customerNameSigned =>
      text().nullable().named('customer_name_signed')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ReportTemplateRow')
class ReportTemplates extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get reportType =>
      text().named('report_type').withDefault(const Constant('work_order'))();
  TextColumn get titlePrefix =>
      text().named('title_prefix').withDefault(const Constant('Rapport'))();
  TextColumn get locale => text().withDefault(const Constant('de'))();
  TextColumn get primaryColor =>
      text().named('primary_color').withDefault(const Constant('#1f2937'))();
  TextColumn get footerText => text().nullable().named('footer_text')();
  BoolColumn get includeCustomer =>
      boolean().named('include_customer').withDefault(const Constant(true))();
  BoolColumn get includeInstallations => boolean()
      .named('include_installations')
      .withDefault(const Constant(true))();
  BoolColumn get includeMeasurements => boolean()
      .named('include_measurements')
      .withDefault(const Constant(true))();
  BoolColumn get includeDefects =>
      boolean().named('include_defects').withDefault(const Constant(true))();
  BoolColumn get includeMaterials =>
      boolean().named('include_materials').withDefault(const Constant(true))();
  BoolColumn get includeTimeEntries => boolean()
      .named('include_time_entries')
      .withDefault(const Constant(true))();
  BoolColumn get includePhotos =>
      boolean().named('include_photos').withDefault(const Constant(true))();
  BoolColumn get includeSignature =>
      boolean().named('include_signature').withDefault(const Constant(true))();
  BoolColumn get isDefault =>
      boolean().named('is_default').withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('OutboxEntryRow')
class OutboxEntries extends Table with SyncColumns {
  TextColumn get entityType => text().named('entity_type')();
  TextColumn get entityId => text().named('entity_id')();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text().named('payload_json')();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastAttemptAt => text().nullable().named('last_attempt_at')();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get errorMessage => text().nullable().named('error_message')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SyncStateRow')
class SyncStates extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text().named('tenant_id')();
  TextColumn get entityType => text().named('entity_type')();
  TextColumn get lastPullAt => text().nullable().named('last_pull_at')();
  TextColumn get lastSuccessfulSyncAt =>
      text().nullable().named('last_successful_sync_at')();
  TextColumn get cursor => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Tenants,
    Users,
    Customers,
    CustomerObjects,
    Installations,
    WorkOrders,
    WorkOrderInstallations,
    ChecklistTemplates,
    ChecklistTemplateItems,
    ChecklistAnswers,
    Measurements,
    Defects,
    Photos,
    TimeEntries,
    Materials,
    WorkOrderMaterials,
    TariffCatalogItems,
    ObjectTariffAssignments,
    WorkOrderServiceLines,
    LegacyImportRecords,
    ReportTemplates,
    Reports,
    OutboxEntries,
    SyncStates,
  ],
  daos: [
    UserDao,
    CustomerDao,
    ObjectDao,
    InstallationDao,
    WorkOrderDao,
    ChecklistDao,
    MeasurementDao,
    DefectDao,
    PhotoDao,
    TimeEntryDao,
    MaterialDao,
    ReportTemplateDao,
    ReportDao,
    OutboxDao,
    SyncStateDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(tariffCatalogItems);
        await migrator.createTable(objectTariffAssignments);
        await migrator.createTable(workOrderServiceLines);
      }
      if (from < 3) {
        await migrator.createTable(legacyImportRecords);
      }
      if (from < 4) {
        await migrator.addColumn(materials, materials.stockQuantity);
        await migrator.addColumn(materials, materials.minStockQuantity);
      }
      if (from < 5) {
        await migrator.createTable(reportTemplates);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> enqueueOutbox({
    required String tenantId,
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, Object?> payload,
  }) async {
    final payloadJson = jsonEncode(payload);
    final now = _utcNowIso();

    if (operation == 'update') {
      final existingUpdate =
          await (select(outboxEntries)
                ..where(
                  (table) =>
                      table.tenantId.equals(tenantId) &
                      table.entityType.equals(entityType) &
                      table.entityId.equals(entityId) &
                      table.operation.equals('update') &
                      table.status.equals('pending') &
                      table.deletedAt.isNull(),
                )
                ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
                ..limit(1))
              .getSingleOrNull();

      if (existingUpdate != null) {
        await update(outboxEntries).replace(
          existingUpdate.copyWith(
            payloadJson: payloadJson,
            updatedAt: now,
            errorMessage: const Value(null),
            syncStatus: 'pending',
          ),
        );
        return;
      }
    }

    await into(outboxEntries).insert(
      OutboxEntriesCompanion.insert(
        id: _uuid.v4(),
        tenantId: tenantId,
        entityType: entityType,
        entityId: entityId,
        operation: operation,
        payloadJson: payloadJson,
        createdAt: Value(now),
        updatedAt: Value(now),
        status: const Value('pending'),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> setEntitySyncStatus({
    required String entityType,
    required String entityId,
    required String syncStatus,
  }) async {
    final tableName = switch (entityType) {
      'customer' => 'customers',
      'object' => 'objects',
      'installation' => 'installations',
      'work_order' => 'work_orders',
      'checklist_answer' => 'checklist_answers',
      'measurement' => 'measurements',
      'defect' => 'defects',
      'photo' => 'photos',
      'time_entry' => 'time_entries',
      'work_order_material' => 'work_order_materials',
      'tariff_catalog_item' => 'tariff_catalog_items',
      'object_tariff_assignment' => 'object_tariff_assignments',
      'work_order_service_line' => 'work_order_service_lines',
      'legacy_import_record' => 'legacy_import_records',
      'report_template' => 'report_templates',
      'report' => 'reports',
      _ => null,
    };

    if (tableName == null) {
      return;
    }

    final now = _utcNowIso();
    await customUpdate(
      'UPDATE $tableName '
      'SET sync_status = ?, last_synced_at = ?, updated_at = ? '
      'WHERE id = ?',
      variables: [
        Variable.withString(syncStatus),
        Variable.withString(now),
        Variable.withString(now),
        Variable.withString(entityId),
      ],
    );
  }

  Future<void> markReportUploaded(String id, {String? remoteUrl}) async {
    final existing = await (select(
      reports,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      return;
    }

    await update(reports).replace(
      existing.copyWith(
        pdfRemoteUrl: Value(remoteUrl ?? existing.pdfRemoteUrl),
        updatedAt: _utcNowIso(),
        syncStatus: 'synced',
        lastSyncedAt: Value(_utcNowIso()),
      ),
    );
  }

  Future<void> markPhotoUploaded(String id, {String? remoteUrl}) async {
    final existing = await photoDao.getById(id);
    if (existing == null) {
      return;
    }

    await update(photos).replace(
      existing.copyWith(
        remoteUrl: Value(remoteUrl ?? existing.remoteUrl),
        uploadStatus: 'uploaded',
        updatedAt: _utcNowIso(),
        syncStatus: 'synced',
        lastSyncedAt: Value(_utcNowIso()),
      ),
    );
  }

  Future<void> seedDevelopmentData() async {
    final existing =
        await (select(tenants)
              ..where((table) => table.id.equals(DevelopmentSeed.tenantId)))
            .getSingleOrNull();

    if (existing != null) {
      return;
    }

    final now = _utcNowIso();
    final today = DateTime.now();
    final startToday = DateTime(
      today.year,
      today.month,
      today.day,
      8,
      30,
    ).toUtc().toIso8601String();
    final endToday = DateTime(
      today.year,
      today.month,
      today.day,
      10,
    ).toUtc().toIso8601String();
    final laterToday = DateTime(
      today.year,
      today.month,
      today.day,
      13,
      15,
    ).toUtc().toIso8601String();
    final laterEnd = DateTime(
      today.year,
      today.month,
      today.day,
      15,
    ).toUtc().toIso8601String();

    await batch((batch) {
      batch.insert(
        tenants,
        TenantsCompanion.insert(
          id: DevelopmentSeed.tenantId,
          tenantId: DevelopmentSeed.tenantId,
          name: 'Kaminfeger Muster AG',
          address: 'Bahnhofstrasse 12',
          postalCode: '8001',
          city: 'Zuerich',
          country: 'CH',
          phone: '+41 44 555 10 10',
          email: 'info@example.ch',
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        users,
        UsersCompanion.insert(
          id: DevelopmentSeed.technicianUserId,
          tenantId: DevelopmentSeed.tenantId,
          firstName: 'Mara',
          lastName: 'Bucher',
          email: 'techniker@example.ch',
          role: 'technician',
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        customers,
        CustomersCompanion.insert(
          id: DevelopmentSeed.customerId,
          tenantId: DevelopmentSeed.tenantId,
          type: 'private',
          displayName: 'Familie Keller',
          firstName: const Value('Nora'),
          lastName: const Value('Keller'),
          email: const Value('nora.keller@example.ch'),
          phone: const Value('+41 79 555 80 80'),
          notes: const Value('Zugang ueber Seiteneingang.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        customerObjects,
        CustomerObjectsCompanion.insert(
          id: DevelopmentSeed.objectId,
          tenantId: DevelopmentSeed.tenantId,
          customerId: DevelopmentSeed.customerId,
          name: 'Einfamilienhaus Keller',
          street: 'Im Ried',
          houseNumber: '7',
          postalCode: '8610',
          city: 'Uster',
          country: 'CH',
          latitude: const Value(47.349962),
          longitude: const Value(8.718269),
          accessNotes: const Value('Schluesselbox beim Carport.'),
          safetyNotes: const Value('Dachzugang nur mit Sicherung.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        installations,
        InstallationsCompanion.insert(
          id: DevelopmentSeed.installationId,
          tenantId: DevelopmentSeed.tenantId,
          objectId: DevelopmentSeed.objectId,
          type: 'fireplace',
          manufacturer: const Value('Rueegg'),
          model: const Value('RIII 45'),
          fuelType: const Value('wood'),
          installationYear: const Value(2016),
          locationDescription: const Value('Wohnzimmer Erdgeschoss'),
          intervalMonths: const Value(12),
          nextServiceDate: Value(startToday),
          notes: const Value('Letzte Reinigung ohne Beanstandung.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        workOrders,
        WorkOrdersCompanion.insert(
          id: DevelopmentSeed.workOrderInspectionId,
          tenantId: DevelopmentSeed.tenantId,
          customerId: DevelopmentSeed.customerId,
          objectId: DevelopmentSeed.objectId,
          assignedUserId: const Value(DevelopmentSeed.technicianUserId),
          orderNumber: 'WO-2026-0001',
          title: 'Jahreskontrolle Cheminée',
          description: const Value('Kontrolle, Reinigung und Messprotokoll.'),
          type: 'inspection',
          status: 'scheduled',
          priority: 'normal',
          scheduledStart: Value(startToday),
          scheduledEnd: Value(endToday),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        workOrders,
        WorkOrdersCompanion.insert(
          id: DevelopmentSeed.workOrderCleaningId,
          tenantId: DevelopmentSeed.tenantId,
          customerId: DevelopmentSeed.customerId,
          objectId: DevelopmentSeed.objectId,
          assignedUserId: const Value(DevelopmentSeed.technicianUserId),
          orderNumber: 'WO-2026-0002',
          title: 'Reinigung Abgasanlage',
          description: const Value('Routine-Reinigung mit Fotodokumentation.'),
          type: 'cleaning',
          status: 'scheduled',
          priority: 'high',
          scheduledStart: Value(laterToday),
          scheduledEnd: Value(laterEnd),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        workOrderInstallations,
        WorkOrderInstallationsCompanion.insert(
          id: '88888888-8888-4888-8888-888888888888',
          tenantId: DevelopmentSeed.tenantId,
          workOrderId: DevelopmentSeed.workOrderInspectionId,
          installationId: DevelopmentSeed.installationId,
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplates,
        ChecklistTemplatesCompanion.insert(
          id: DevelopmentSeed.checklistTemplateId,
          tenantId: DevelopmentSeed.tenantId,
          name: 'Kontrolle Feuerstaette Standard',
          type: 'inspection',
          versionNumber: 1,
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        reportTemplates,
        ReportTemplatesCompanion.insert(
          id: DevelopmentSeed.reportTemplateId,
          tenantId: DevelopmentSeed.tenantId,
          name: 'Standard Rapport',
          reportType: const Value('work_order'),
          titlePrefix: const Value('Rapport'),
          locale: const Value('de'),
          primaryColor: const Value('#1f2937'),
          footerText: const Value('Kaminfeger Muster AG'),
          includeCustomer: const Value(true),
          includeInstallations: const Value(true),
          includeMeasurements: const Value(true),
          includeDefects: const Value(true),
          includeMaterials: const Value(true),
          includeTimeEntries: const Value(true),
          includePhotos: const Value(true),
          includeSignature: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 1,
          label: 'Feuerstaette frei von sichtbaren Maengeln?',
          answerType: 'yes_no',
          required: const Value(true),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaab',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 2,
          label: 'Allgemeine Bemerkung',
          answerType: 'text',
          helpText: const Value('Kurz dokumentieren, falls etwas auffaellt.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaac',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 3,
          label: 'Abgastemperatur plausibel?',
          answerType: 'number',
          required: const Value(true),
          helpText: const Value('Wert in Grad Celsius erfassen.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaad',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 4,
          label: 'Reinigungsbedarf',
          answerType: 'single_select',
          required: const Value(true),
          optionsJson: Value(jsonEncode(['kein', 'normal', 'hoch'])),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaae',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 5,
          label: 'Durchgefuehrte Arbeiten',
          answerType: 'multi_select',
          optionsJson: Value(
            jsonEncode(['Sichtkontrolle', 'Reinigung', 'Messung']),
          ),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        checklistTemplateItems,
        ChecklistTemplateItemsCompanion.insert(
          id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaf',
          tenantId: DevelopmentSeed.tenantId,
          templateId: DevelopmentSeed.checklistTemplateId,
          position: 6,
          label: 'Foto bei Auffaelligkeit erforderlich',
          answerType: 'photo_required',
          helpText: const Value('Fotopflicht vormerken, Upload folgt spaeter.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        materials,
        MaterialsCompanion.insert(
          id: DevelopmentSeed.materialCleaningId,
          tenantId: DevelopmentSeed.tenantId,
          sku: const Value('REIN-001'),
          name: 'Reinigungspauschale Kleinauftrag',
          unit: 'Stueck',
          defaultPrice: const Value(85),
          stockQuantity: const Value(6),
          minStockQuantity: const Value(2),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        tariffCatalogItems,
        TariffCatalogItemsCompanion.insert(
          id: DevelopmentSeed.tariffCatalogInspectionId,
          tenantId: DevelopmentSeed.tenantId,
          tariffSystem: 'kfd',
          code: 'K-100',
          description: 'Jahreskontrolle Holzfeuerung',
          defaultPrice: const Value(120),
          taxPoints: const Value(12),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        tariffCatalogItems,
        TariffCatalogItemsCompanion.insert(
          id: DevelopmentSeed.tariffCatalogCleaningId,
          tenantId: DevelopmentSeed.tenantId,
          tariffSystem: 'kfd',
          code: 'R-210',
          description: 'Reinigung Abgasanlage',
          defaultPrice: const Value(95),
          taxPoints: const Value(9.5),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        objectTariffAssignments,
        ObjectTariffAssignmentsCompanion.insert(
          id: DevelopmentSeed.objectTariffInspectionId,
          tenantId: DevelopmentSeed.tenantId,
          objectId: const Value(DevelopmentSeed.objectId),
          tariffCatalogItemId: const Value(
            DevelopmentSeed.tariffCatalogInspectionId,
          ),
          tariffSystem: 'kfd',
          code: const Value('K-100'),
          description: 'Jahreskontrolle Holzfeuerung',
          position: const Value(1),
          defaultQuantity: const Value(1),
          unit: const Value('Stk'),
          priceOverride: const Value(120),
          taxPoints: const Value(12),
          billingCode: const Value('HOLZ-KONTROLLE'),
          notes: const Value('Aus Genesis Objekt-Tarif zugeordnet.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        objectTariffAssignments,
        ObjectTariffAssignmentsCompanion.insert(
          id: DevelopmentSeed.objectTariffCleaningId,
          tenantId: DevelopmentSeed.tenantId,
          objectId: const Value(DevelopmentSeed.objectId),
          tariffCatalogItemId: const Value(
            DevelopmentSeed.tariffCatalogCleaningId,
          ),
          tariffSystem: 'kfd',
          code: const Value('R-210'),
          description: 'Reinigung Abgasanlage',
          position: const Value(2),
          defaultQuantity: const Value(1),
          unit: const Value('Stk'),
          priceOverride: const Value(95),
          taxPoints: const Value(9.5),
          billingCode: const Value('REINIGUNG'),
          notes: const Value('Aus Genesis Objekt-Tarif zugeordnet.'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      batch.insert(
        syncStates,
        SyncStatesCompanion.insert(
          id: 'sync-work-orders',
          tenantId: DevelopmentSeed.tenantId,
          entityType: 'work_orders',
          cursor: const Value('development-seed'),
        ),
      );
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(path.join(directory.path, 'kaminfeger.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Stream<List<UserRow>> watchActive(String tenantId) {
    return (select(users)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.lastName),
            (table) => OrderingTerm.asc(table.firstName),
          ]))
        .watch();
  }
}

@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  Future<CustomerRow?> getById(String id) {
    return (select(
      customers,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<CustomerRow>> watchActive(String tenantId) {
    return (select(customers)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.displayName)]))
        .watch();
  }

  Future<void> updateNotesLocal({required String id, String? notes}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final next = existing.copyWith(
      notes: Value(notes),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(customers).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'customer',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [CustomerObjects])
class ObjectDao extends DatabaseAccessor<AppDatabase> with _$ObjectDaoMixin {
  ObjectDao(super.db);

  Future<CustomerObjectRow?> getById(String id) {
    return (select(
      customerObjects,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<CustomerObjectRow>> watchActive(String tenantId) {
    return (select(customerObjects)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.city),
            (table) => OrderingTerm.asc(table.street),
          ]))
        .watch();
  }

  Stream<List<CustomerObjectRow>> watchForCustomer(
    String tenantId,
    String customerId,
  ) {
    return (select(customerObjects)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.customerId.equals(customerId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.city),
            (table) => OrderingTerm.asc(table.street),
          ]))
        .watch();
  }

  Future<void> updateNotesLocal({required String id, String? notes}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final next = existing.copyWith(
      objectNotes: Value(notes),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(customerObjects).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'object',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [Installations])
class InstallationDao extends DatabaseAccessor<AppDatabase>
    with _$InstallationDaoMixin {
  InstallationDao(super.db);

  Future<InstallationRow?> getById(String id) {
    return (select(
      installations,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<InstallationRow>> watchActive(String tenantId) {
    return (select(installations)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.type),
            (table) => OrderingTerm.asc(table.manufacturer),
          ]))
        .watch();
  }

  Stream<List<InstallationRow>> watchForObject(
    String tenantId,
    String objectId,
  ) {
    return (select(installations)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.objectId.equals(objectId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.locationDescription)]))
        .watch();
  }

  Future<void> updateNotesLocal({required String id, String? notes}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final next = existing.copyWith(
      notes: Value(notes),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(installations).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'installation',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }
}

final class WorkOrderDetailHeaderRow {
  const WorkOrderDetailHeaderRow({
    required this.workOrder,
    required this.customer,
    required this.object,
  });

  final WorkOrderRow workOrder;
  final CustomerRow customer;
  final CustomerObjectRow object;
}

final class WorkOrderRouteStopRow {
  const WorkOrderRouteStopRow({required this.workOrder, required this.object});

  final WorkOrderRow workOrder;
  final CustomerObjectRow object;
}

final class DueRecurringWorkOrderRow {
  const DueRecurringWorkOrderRow({
    required this.installation,
    required this.object,
    required this.customer,
  });

  final InstallationRow installation;
  final CustomerObjectRow object;
  final CustomerRow customer;
}

@DriftAccessor(
  tables: [
    WorkOrders,
    Customers,
    CustomerObjects,
    Installations,
    WorkOrderInstallations,
    TimeEntries,
    ObjectTariffAssignments,
    WorkOrderServiceLines,
    OutboxEntries,
  ],
)
class WorkOrderDao extends DatabaseAccessor<AppDatabase>
    with _$WorkOrderDaoMixin {
  WorkOrderDao(super.db);

  Stream<List<WorkOrderRow>> watchActive(String tenantId) {
    return (select(workOrders)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.scheduledStart),
            (table) => OrderingTerm.asc(table.orderNumber),
          ]))
        .watch();
  }

  Stream<List<WorkOrderRow>> watchToday(String tenantId, DateTime day) {
    return watchActive(tenantId).map(
      (rows) => rows
          .where((row) => _isSameLocalDate(row.scheduledStart, day))
          .toList(growable: false),
    );
  }

  Stream<List<WorkOrderRouteStopRow>> watchTodayRouteStops(
    String tenantId,
    DateTime day,
  ) {
    final query =
        select(workOrders).join([
          innerJoin(
            customerObjects,
            customerObjects.id.equalsExp(workOrders.objectId),
          ),
        ])..where(
          workOrders.tenantId.equals(tenantId) &
              workOrders.deletedAt.isNull() &
              customerObjects.deletedAt.isNull(),
        );

    return query.watch().map((rows) {
      final stops = rows
          .map(
            (row) => WorkOrderRouteStopRow(
              workOrder: row.readTable(workOrders),
              object: row.readTable(customerObjects),
            ),
          )
          .where((row) => _isSameLocalDate(row.workOrder.scheduledStart, day))
          .toList(growable: false);
      stops.sort((a, b) {
        final startCompare = _compareIsoDateTime(
          a.workOrder.scheduledStart,
          b.workOrder.scheduledStart,
        );
        if (startCompare != 0) {
          return startCompare;
        }
        return a.workOrder.orderNumber.compareTo(b.workOrder.orderNumber);
      });
      return stops;
    });
  }

  Stream<List<DueRecurringWorkOrderRow>> watchDueRecurringCandidates(
    String tenantId,
    DateTime dueOn,
  ) {
    final query =
        select(installations).join([
          innerJoin(
            customerObjects,
            customerObjects.id.equalsExp(installations.objectId),
          ),
          innerJoin(
            customers,
            customers.id.equalsExp(customerObjects.customerId),
          ),
          leftOuterJoin(
            workOrderInstallations,
            workOrderInstallations.installationId.equalsExp(installations.id) &
                workOrderInstallations.deletedAt.isNull(),
          ),
          leftOuterJoin(
            workOrders,
            workOrders.id.equalsExp(workOrderInstallations.workOrderId) &
                workOrders.deletedAt.isNull(),
          ),
        ])..where(
          installations.tenantId.equals(tenantId) &
              installations.deletedAt.isNull() &
              customerObjects.deletedAt.isNull() &
              customers.deletedAt.isNull(),
        );

    return query.watch().map((rows) {
      final grouped = <String, _RecurringCandidateAccumulator>{};
      for (final row in rows) {
        final installation = row.readTable(installations);
        final object = row.readTable(customerObjects);
        final customer = row.readTable(customers);
        final linkedOrder = row.readTableOrNull(workOrders);

        final accumulator = grouped.putIfAbsent(
          installation.id,
          () => _RecurringCandidateAccumulator(
            installation: installation,
            object: object,
            customer: customer,
          ),
        );
        final dueDate = DateTime.tryParse(installation.nextServiceDate ?? '');
        if (dueDate != null &&
            linkedOrder != null &&
            linkedOrder.status != 'cancelled' &&
            _isSameLocalDate(linkedOrder.scheduledStart, dueDate)) {
          accumulator.hasExistingOrderForDueDate = true;
        }
      }

      final due = grouped.values
          .where(
            (item) =>
                !item.hasExistingOrderForDueDate &&
                _isDueRecurringInstallation(item.installation, dueOn),
          )
          .map(
            (item) => DueRecurringWorkOrderRow(
              installation: item.installation,
              object: item.object,
              customer: item.customer,
            ),
          )
          .toList(growable: false);
      due.sort((left, right) {
        final dateCompare = _compareIsoDateTime(
          left.installation.nextServiceDate,
          right.installation.nextServiceDate,
        );
        if (dateCompare != 0) {
          return dateCompare;
        }
        return left.object.name.compareTo(right.object.name);
      });
      return due;
    });
  }

  Stream<List<WorkOrderRow>> watchForCustomer(
    String tenantId,
    String customerId,
  ) {
    return (select(workOrders)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.customerId.equals(customerId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.desc(table.scheduledStart),
            (table) => OrderingTerm.asc(table.orderNumber),
          ]))
        .watch();
  }

  Stream<List<WorkOrderRow>> watchForObject(String tenantId, String objectId) {
    return (select(workOrders)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.objectId.equals(objectId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.desc(table.scheduledStart),
            (table) => OrderingTerm.asc(table.orderNumber),
          ]))
        .watch();
  }

  Stream<List<WorkOrderRow>> watchForInstallation(
    String tenantId,
    String installationId,
  ) {
    final query =
        select(workOrders).join([
          innerJoin(
            workOrderInstallations,
            workOrderInstallations.workOrderId.equalsExp(workOrders.id),
          ),
        ])..where(
          workOrders.tenantId.equals(tenantId) &
              workOrders.deletedAt.isNull() &
              workOrderInstallations.deletedAt.isNull() &
              workOrderInstallations.installationId.equals(installationId),
        );

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(workOrders)).toList(),
    );
  }

  Future<WorkOrderRow?> getById(String id) {
    return (select(
      workOrders,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<WorkOrderDetailHeaderRow?> watchDetailHeader(
    String tenantId,
    String id,
  ) {
    final query =
        select(workOrders).join([
          innerJoin(customers, customers.id.equalsExp(workOrders.customerId)),
          innerJoin(
            customerObjects,
            customerObjects.id.equalsExp(workOrders.objectId),
          ),
        ])..where(
          workOrders.id.equals(id) &
              workOrders.tenantId.equals(tenantId) &
              workOrders.deletedAt.isNull() &
              customers.deletedAt.isNull() &
              customerObjects.deletedAt.isNull(),
        );

    return query.watch().map((rows) {
      if (rows.isEmpty) {
        return null;
      }

      final row = rows.first;
      return WorkOrderDetailHeaderRow(
        workOrder: row.readTable(workOrders),
        customer: row.readTable(customers),
        object: row.readTable(customerObjects),
      );
    });
  }

  Stream<List<ObjectTariffAssignmentRow>> watchObjectTariffs(
    String tenantId,
    String objectId,
  ) {
    return (select(objectTariffAssignments)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.objectId.equals(objectId) &
                table.deletedAt.isNull() &
                table.isActive.equals(true),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.position),
            (table) => OrderingTerm.asc(table.description),
          ]))
        .watch();
  }

  Stream<List<WorkOrderServiceLineRow>> watchServiceLines(
    String tenantId,
    String workOrderId,
  ) {
    return (select(workOrderServiceLines)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.name),
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .watch();
  }

  Future<void> createServiceLineLocal({
    required String tenantId,
    required String workOrderId,
    required String name,
    required double quantity,
    required String unit,
    String? objectTariffAssignmentId,
    String? tariffCatalogItemId,
    String? installationId,
    String? code,
    double? unitPrice,
    double? taxPoints,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = _utcNowIso();
    final totalPrice = unitPrice == null ? null : unitPrice * quantity;

    await transaction(() async {
      await into(workOrderServiceLines).insert(
        WorkOrderServiceLinesCompanion.insert(
          id: id,
          tenantId: tenantId,
          workOrderId: workOrderId,
          objectTariffAssignmentId: Value(objectTariffAssignmentId),
          tariffCatalogItemId: Value(tariffCatalogItemId),
          installationId: Value(installationId),
          code: Value(code),
          name: name,
          quantity: quantity,
          unit: unit,
          unitPrice: Value(unitPrice),
          totalPrice: Value(totalPrice),
          taxPoints: Value(taxPoints),
          notes: Value(notes),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'work_order_service_line',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'workOrderId': workOrderId,
          'objectTariffAssignmentId': objectTariffAssignmentId,
          'tariffCatalogItemId': tariffCatalogItemId,
          'installationId': installationId,
          'code': code,
          'name': name,
          'quantity': quantity,
          'unit': unit,
          'unitPrice': unitPrice,
          'totalPrice': totalPrice,
          'taxPoints': taxPoints,
          'status': 'performed',
          'notes': notes,
        },
      );
    });
  }

  Future<List<WorkOrderRow>> createDueRecurringLocal({
    required String tenantId,
    required String userId,
    required DateTime dueOn,
  }) async {
    final candidates = await watchDueRecurringCandidates(tenantId, dueOn).first;
    if (candidates.isEmpty) {
      return const [];
    }

    final created = <WorkOrderRow>[];
    await transaction(() async {
      for (final candidate in candidates) {
        if (await _hasWorkOrderForInstallationDueDate(candidate.installation)) {
          continue;
        }

        final workOrder = _buildRecurringWorkOrder(
          candidate: candidate,
          userId: userId,
        );
        final link = _buildRecurringWorkOrderInstallation(
          tenantId: tenantId,
          workOrderId: workOrder.id,
          installationId: candidate.installation.id,
        );
        final updatedInstallation = _advanceRecurringInstallation(
          candidate.installation,
          dueOn: dueOn,
        );

        await into(workOrders).insert(workOrder);
        await into(workOrderInstallations).insert(link);
        await update(installations).replace(updatedInstallation);
        await db.enqueueOutbox(
          tenantId: tenantId,
          entityType: 'work_order',
          entityId: workOrder.id,
          operation: 'create',
          payload: workOrder.toJson(),
        );
        await db.enqueueOutbox(
          tenantId: tenantId,
          entityType: 'work_order_installation',
          entityId: link.id,
          operation: 'create',
          payload: link.toJson(),
        );
        await db.enqueueOutbox(
          tenantId: tenantId,
          entityType: 'installation',
          entityId: updatedInstallation.id,
          operation: 'update',
          payload: updatedInstallation.toJson(),
        );
        created.add(workOrder);
      }
    });

    return created;
  }

  Future<void> startLocal({required String id, required String userId}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final now = _utcNowIso();
    await transaction(() async {
      final updated = existing.copyWith(
        status: 'in_progress',
        actualStart: Value(existing.actualStart ?? now),
      );
      await _replaceWithOutbox(updated, operation: 'update');
      await _createTimeEntry(
        tenantId: existing.tenantId,
        workOrderId: existing.id,
        userId: userId,
        type: 'work',
        startTime: now,
      );
    });
  }

  Future<void> pauseLocal(String id) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final now = _utcNowIso();
    await transaction(() async {
      await _replaceWithOutbox(
        existing.copyWith(status: 'paused'),
        operation: 'update',
      );
      await _closeOpenTimeEntry(existing.id, now);
    });
  }

  Future<void> resumeLocal({required String id, required String userId}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final now = _utcNowIso();
    await transaction(() async {
      await _replaceWithOutbox(
        existing.copyWith(status: 'in_progress'),
        operation: 'update',
      );
      await _createTimeEntry(
        tenantId: existing.tenantId,
        workOrderId: existing.id,
        userId: userId,
        type: 'work',
        startTime: now,
      );
    });
  }

  Future<void> completeLocal(String id, {String? notes}) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final now = _utcNowIso();
    await transaction(() async {
      await _replaceWithOutbox(
        existing.copyWith(
          status: 'completed',
          actualEnd: Value(existing.actualEnd ?? now),
          completionNotes: Value(notes ?? existing.completionNotes),
        ),
        operation: 'update',
      );
      await _closeOpenTimeEntry(existing.id, now);
    });
  }

  Future<void> attachSignatureLocal({
    required String id,
    required String signatureFileId,
  }) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    await _replaceWithOutbox(
      existing.copyWith(customerSignatureFileId: Value(signatureFileId)),
      operation: 'update',
    );
  }

  Future<void> attachReportLocal({
    required String id,
    required String reportFileId,
  }) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    await _replaceWithOutbox(
      existing.copyWith(reportFileId: Value(reportFileId)),
      operation: 'update',
    );
  }

  Future<void> upsertLocal(WorkOrderRow row) async {
    final existing = await getById(row.id);
    final now = _utcNowIso();
    final next = row.copyWith(
      updatedAt: now,
      version: existing == null ? row.version : existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await into(workOrders).insertOnConflictUpdate(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'work_order',
        entityId: next.id,
        operation: existing == null ? 'create' : 'update',
        payload: next.toJson(),
      );
    });
  }

  Future<void> softDeleteLocal(String id) async {
    final existing = await getById(id);
    if (existing == null || existing.deletedAt != null) {
      return;
    }

    final now = _utcNowIso();
    final deleted = existing.copyWith(
      deletedAt: Value(now),
      updatedAt: now,
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(workOrders).replace(deleted);
      await db.enqueueOutbox(
        tenantId: deleted.tenantId,
        entityType: 'work_order',
        entityId: deleted.id,
        operation: 'delete',
        payload: deleted.toJson(),
      );
    });
  }

  Future<void> _replaceWithOutbox(
    WorkOrderRow row, {
    required String operation,
  }) async {
    final existing = await getById(row.id);
    final now = _utcNowIso();
    final next = row.copyWith(
      updatedAt: now,
      version: (existing?.version ?? row.version) + 1,
      syncStatus: 'pending',
    );

    await update(workOrders).replace(next);
    await db.enqueueOutbox(
      tenantId: next.tenantId,
      entityType: 'work_order',
      entityId: next.id,
      operation: operation,
      payload: next.toJson(),
    );
  }

  Future<bool> _hasWorkOrderForInstallationDueDate(
    InstallationRow installation,
  ) async {
    final dueDate = DateTime.tryParse(installation.nextServiceDate ?? '');
    if (dueDate == null) {
      return true;
    }

    final query =
        select(workOrders).join([
          innerJoin(
            workOrderInstallations,
            workOrderInstallations.workOrderId.equalsExp(workOrders.id),
          ),
        ])..where(
          workOrders.tenantId.equals(installation.tenantId) &
              workOrders.deletedAt.isNull() &
              workOrders.status.equals('cancelled').not() &
              workOrderInstallations.deletedAt.isNull() &
              workOrderInstallations.installationId.equals(installation.id),
        );

    final rows = await query.get();
    return rows.any(
      (row) =>
          _isSameLocalDate(row.readTable(workOrders).scheduledStart, dueDate),
    );
  }

  WorkOrderRow _buildRecurringWorkOrder({
    required DueRecurringWorkOrderRow candidate,
    required String userId,
  }) {
    final id = _uuid.v4();
    final now = _utcNowIso();
    final dueDate = DateTime.parse(candidate.installation.nextServiceDate!);
    final scheduledStart = _dateWithLocalTime(dueDate, hour: 8).toUtc();
    final scheduledEnd = scheduledStart.add(const Duration(hours: 1));
    final installationName = _installationDisplayName(candidate.installation);

    return WorkOrderRow(
      id: id,
      tenantId: candidate.installation.tenantId,
      createdAt: now,
      updatedAt: now,
      version: 1,
      syncStatus: 'pending',
      customerId: candidate.customer.id,
      objectId: candidate.object.id,
      assignedUserId: userId,
      orderNumber: _recurringOrderNumber(id, scheduledStart),
      title: 'Wiederkehrende Arbeit $installationName',
      description:
          'Automatisch aus dem ${candidate.installation.intervalMonths}-Monats-Intervall der Anlage erzeugt.',
      type: 'recurring_service',
      status: 'scheduled',
      priority: 'normal',
      scheduledStart: scheduledStart.toIso8601String(),
      scheduledEnd: scheduledEnd.toIso8601String(),
    );
  }

  WorkOrderInstallationRow _buildRecurringWorkOrderInstallation({
    required String tenantId,
    required String workOrderId,
    required String installationId,
  }) {
    final now = _utcNowIso();
    return WorkOrderInstallationRow(
      id: _uuid.v4(),
      tenantId: tenantId,
      createdAt: now,
      updatedAt: now,
      version: 1,
      syncStatus: 'pending',
      workOrderId: workOrderId,
      installationId: installationId,
    );
  }

  InstallationRow _advanceRecurringInstallation(
    InstallationRow installation, {
    required DateTime dueOn,
  }) {
    final interval = installation.intervalMonths ?? 0;
    final nextDate = DateTime.parse(installation.nextServiceDate!);
    var advanced = _addMonths(nextDate, interval);
    while (!_isAfterLocalDate(advanced, dueOn)) {
      advanced = _addMonths(advanced, interval);
    }

    return installation.copyWith(
      nextServiceDate: Value(advanced.toUtc().toIso8601String()),
      updatedAt: _utcNowIso(),
      version: installation.version + 1,
      syncStatus: 'pending',
    );
  }

  Future<void> _createTimeEntry({
    required String tenantId,
    required String workOrderId,
    required String userId,
    required String type,
    required String startTime,
  }) async {
    final id = _uuid.v4();
    final entry = TimeEntriesCompanion.insert(
      id: id,
      tenantId: tenantId,
      workOrderId: workOrderId,
      userId: userId,
      type: type,
      startTime: startTime,
      syncStatus: const Value('pending'),
    );

    await into(timeEntries).insert(entry);
    await db.enqueueOutbox(
      tenantId: tenantId,
      entityType: 'time_entry',
      entityId: id,
      operation: 'create',
      payload: {
        'id': id,
        'tenant_id': tenantId,
        'work_order_id': workOrderId,
        'user_id': userId,
        'type': type,
        'start_time': startTime,
        'sync_status': 'pending',
      },
    );
  }

  Future<void> _closeOpenTimeEntry(String workOrderId, String endTime) async {
    final openEntry =
        await (select(timeEntries)
              ..where(
                (table) =>
                    table.workOrderId.equals(workOrderId) &
                    table.endTime.isNull() &
                    table.deletedAt.isNull(),
              )
              ..orderBy([(table) => OrderingTerm.desc(table.startTime)])
              ..limit(1))
            .getSingleOrNull();

    if (openEntry == null) {
      return;
    }

    final updated = openEntry.copyWith(
      endTime: Value(endTime),
      durationMinutes: Value(_minutesBetweenIso(openEntry.startTime, endTime)),
      updatedAt: _utcNowIso(),
      version: openEntry.version + 1,
      syncStatus: 'pending',
    );

    await update(timeEntries).replace(updated);
    await db.enqueueOutbox(
      tenantId: updated.tenantId,
      entityType: 'time_entry',
      entityId: updated.id,
      operation: 'update',
      payload: updated.toJson(),
    );
  }

  static bool _isSameLocalDate(String? isoString, DateTime day) {
    if (isoString == null) {
      return false;
    }

    final parsed = DateTime.tryParse(isoString)?.toLocal();
    if (parsed == null) {
      return false;
    }

    return parsed.year == day.year &&
        parsed.month == day.month &&
        parsed.day == day.day;
  }

  static bool _isDueRecurringInstallation(
    InstallationRow installation,
    DateTime dueOn,
  ) {
    final nextServiceDate = DateTime.tryParse(
      installation.nextServiceDate ?? '',
    );
    final interval = installation.intervalMonths;
    if (nextServiceDate == null || interval == null || interval <= 0) {
      return false;
    }

    return !_isAfterLocalDate(nextServiceDate, dueOn);
  }

  static bool _isAfterLocalDate(DateTime left, DateTime right) {
    final leftLocal = left.toLocal();
    final rightLocal = right.toLocal();
    final leftDate = DateTime(leftLocal.year, leftLocal.month, leftLocal.day);
    final rightDate = DateTime(
      rightLocal.year,
      rightLocal.month,
      rightLocal.day,
    );
    return leftDate.isAfter(rightDate);
  }

  static int _compareIsoDateTime(String? left, String? right) {
    final leftDate = left == null ? null : DateTime.tryParse(left);
    final rightDate = right == null ? null : DateTime.tryParse(right);
    if (leftDate == null && rightDate == null) {
      return 0;
    }
    if (leftDate == null) {
      return 1;
    }
    if (rightDate == null) {
      return -1;
    }
    return leftDate.compareTo(rightDate);
  }

  static DateTime _dateWithLocalTime(DateTime value, {required int hour}) {
    final local = value.toLocal();
    return DateTime(local.year, local.month, local.day, hour);
  }

  static DateTime _addMonths(DateTime value, int months) {
    final local = value.toLocal();
    final targetMonth = local.month + months;
    final targetYear = local.year + ((targetMonth - 1) ~/ 12);
    final normalizedMonth = ((targetMonth - 1) % 12) + 1;
    final day = local.day.clamp(1, _daysInMonth(targetYear, normalizedMonth));
    return DateTime(
      targetYear,
      normalizedMonth,
      day,
      local.hour,
      local.minute,
      local.second,
      local.millisecond,
      local.microsecond,
    );
  }

  static int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  static String _installationDisplayName(InstallationRow row) {
    final parts = [row.manufacturer, row.model]
        .where((part) => part != null && part.trim().isNotEmpty)
        .cast<String>()
        .join(' ');
    return parts.isEmpty ? row.type : parts;
  }

  static String _recurringOrderNumber(String id, DateTime scheduledStart) {
    final date = scheduledStart.toUtc();
    String two(int value) => value.toString().padLeft(2, '0');
    return 'WO-REC-${date.year}${two(date.month)}${two(date.day)}-'
        '${id.substring(0, 8).toUpperCase()}';
  }
}

final class _RecurringCandidateAccumulator {
  _RecurringCandidateAccumulator({
    required this.installation,
    required this.object,
    required this.customer,
  });

  final InstallationRow installation;
  final CustomerObjectRow object;
  final CustomerRow customer;
  bool hasExistingOrderForDueDate = false;
}

@DriftAccessor(
  tables: [ChecklistTemplates, ChecklistTemplateItems, ChecklistAnswers],
)
class ChecklistDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistDaoMixin {
  ChecklistDao(super.db);

  Stream<List<ChecklistTemplateRow>> watchActiveTemplates(String tenantId) {
    return (select(checklistTemplates)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.deletedAt.isNull() &
                table.isActive.equals(true),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  Stream<List<ChecklistAnswerRow>> watchAnswersForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(checklistAnswers)..where(
          (table) =>
              table.tenantId.equals(tenantId) &
              table.workOrderId.equals(workOrderId) &
              table.deletedAt.isNull(),
        ))
        .watch();
  }

  Future<ChecklistTemplateRow?> getActiveTemplateForType(
    String tenantId,
    String type,
  ) {
    return (select(checklistTemplates)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.type.equals(type) &
                table.isActive.equals(true) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.versionNumber)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<ChecklistTemplateItemRow>> getTemplateItems(
    String tenantId,
    String templateId,
  ) {
    return (select(checklistTemplateItems)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.templateId.equals(templateId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.position)]))
        .get();
  }

  Future<ChecklistAnswerRow?> getAnswerForItem({
    required String tenantId,
    required String workOrderId,
    required String templateItemId,
  }) {
    return (select(checklistAnswers)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.templateItemId.equals(templateItemId) &
                table.deletedAt.isNull(),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<ChecklistAnswerRow?> getAnswerById(String id) {
    return (select(
      checklistAnswers,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<void> createAnswersFromTemplate({
    required String tenantId,
    required String workOrderId,
    required String workOrderType,
  }) async {
    final template = await getActiveTemplateForType(tenantId, workOrderType);
    if (template == null) {
      return;
    }

    final items = await getTemplateItems(tenantId, template.id);
    final now = _utcNowIso();

    await transaction(() async {
      for (final item in items) {
        final existing = await getAnswerForItem(
          tenantId: tenantId,
          workOrderId: workOrderId,
          templateItemId: item.id,
        );
        if (existing != null) {
          continue;
        }

        final id = _uuid.v4();
        await into(checklistAnswers).insert(
          ChecklistAnswersCompanion.insert(
            id: id,
            tenantId: tenantId,
            workOrderId: workOrderId,
            templateItemId: item.id,
            createdAt: Value(now),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
        await db.enqueueOutbox(
          tenantId: tenantId,
          entityType: 'checklist_answer',
          entityId: id,
          operation: 'create',
          payload: {
            'id': id,
            'tenant_id': tenantId,
            'work_order_id': workOrderId,
            'template_item_id': item.id,
            'answer_value': null,
            'comment': null,
            'is_ok': null,
          },
        );
      }
    });
  }

  Future<void> saveAnswerLocal({
    required String answerId,
    String? answerValue,
    String? comment,
    bool? isOk,
  }) async {
    final existing = await getAnswerById(answerId);
    if (existing == null) {
      return;
    }

    final updated = existing.copyWith(
      answerValue: Value(answerValue),
      comment: Value(comment),
      isOk: Value(isOk),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(checklistAnswers).replace(updated);
      await db.enqueueOutbox(
        tenantId: updated.tenantId,
        entityType: 'checklist_answer',
        entityId: updated.id,
        operation: 'update',
        payload: updated.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [Measurements])
class MeasurementDao extends DatabaseAccessor<AppDatabase>
    with _$MeasurementDaoMixin {
  MeasurementDao(super.db);

  Stream<List<MeasurementRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(measurements)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.measuredAt)]))
        .watch();
  }

  Future<void> createLocal({
    required String tenantId,
    required String workOrderId,
    required String measurementType,
    required double value,
    required String unit,
    String? installationId,
    String? deviceName,
    String? deviceSerial,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final measuredAt = _utcNowIso();

    await transaction(() async {
      await into(measurements).insert(
        MeasurementsCompanion.insert(
          id: id,
          tenantId: tenantId,
          workOrderId: workOrderId,
          installationId: Value(installationId),
          measurementType: measurementType,
          value: value,
          unit: unit,
          measuredAt: measuredAt,
          deviceName: Value(deviceName),
          deviceSerial: Value(deviceSerial),
          notes: Value(notes),
          syncStatus: const Value('pending'),
        ),
      );
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'measurement',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'installation_id': installationId,
          'measurement_type': measurementType,
          'value': value,
          'unit': unit,
          'measured_at': measuredAt,
          'device_name': deviceName,
          'device_serial': deviceSerial,
          'notes': notes,
        },
      );
    });
  }
}

@DriftAccessor(tables: [Defects])
class DefectDao extends DatabaseAccessor<AppDatabase> with _$DefectDaoMixin {
  DefectDao(super.db);

  Stream<List<DefectRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(defects)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.desc(table.severity),
            (table) => OrderingTerm.asc(table.title),
          ]))
        .watch();
  }

  Future<DefectRow?> getById(String id) {
    return (select(
      defects,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<void> createLocal({
    required String tenantId,
    required String workOrderId,
    required String severity,
    required String title,
    required String description,
    String? installationId,
    String? recommendedAction,
    String? dueDate,
  }) async {
    final id = _uuid.v4();
    final now = _utcNowIso();
    final row = DefectsCompanion.insert(
      id: id,
      tenantId: tenantId,
      workOrderId: workOrderId,
      installationId: Value(installationId),
      severity: severity,
      title: title,
      description: description,
      recommendedAction: Value(recommendedAction),
      dueDate: Value(dueDate),
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await transaction(() async {
      await into(defects).insert(row);
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'defect',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'installation_id': installationId,
          'severity': severity,
          'title': title,
          'description': description,
          'recommended_action': recommendedAction,
          'due_date': dueDate,
          'resolved': false,
        },
      );
    });
  }

  Future<void> updateLocal(DefectRow row) async {
    final existing = await getById(row.id);
    if (existing == null) {
      return;
    }

    final next = row.copyWith(
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(defects).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'defect',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }

  Future<void> softDeleteLocal(String id) async {
    final existing = await getById(id);
    if (existing == null || existing.deletedAt != null) {
      return;
    }

    final next = existing.copyWith(
      deletedAt: Value(_utcNowIso()),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(defects).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'defect',
        entityId: next.id,
        operation: 'delete',
        payload: next.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [Photos])
class PhotoDao extends DatabaseAccessor<AppDatabase> with _$PhotoDaoMixin {
  PhotoDao(super.db);

  Stream<List<PhotoRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(photos)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.takenAt)]))
        .watch();
  }

  Stream<List<PhotoRow>> watchForDefect(String tenantId, String defectId) {
    return (select(photos)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.defectId.equals(defectId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.takenAt)]))
        .watch();
  }

  Stream<List<PhotoRow>> watchForInstallation(
    String tenantId,
    String installationId,
  ) {
    return (select(photos)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.installationId.equals(installationId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.takenAt)]))
        .watch();
  }

  Future<PhotoRow?> getById(String id) {
    return (select(
      photos,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<String> createLocal({
    required String tenantId,
    required String localPath,
    required String fileName,
    required String mimeType,
    required int sizeBytes,
    String? workOrderId,
    String? objectId,
    String? installationId,
    String? defectId,
    String? caption,
  }) async {
    final id = _uuid.v4();
    final now = _utcNowIso();
    final row = PhotosCompanion.insert(
      id: id,
      tenantId: tenantId,
      workOrderId: Value(workOrderId),
      objectId: Value(objectId),
      installationId: Value(installationId),
      defectId: Value(defectId),
      localPath: localPath,
      fileName: fileName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      caption: Value(caption),
      takenAt: now,
      uploadStatus: 'pending',
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await transaction(() async {
      await into(photos).insert(row);
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'photo',
        entityId: id,
        operation: 'upload_file',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'object_id': objectId,
          'installation_id': installationId,
          'defect_id': defectId,
          'local_path': localPath,
          'file_name': fileName,
          'mime_type': mimeType,
          'size_bytes': sizeBytes,
          'caption': caption,
          'taken_at': now,
          'upload_status': 'pending',
        },
      );
    });

    return id;
  }

  Future<void> updateCaptionLocal({
    required String id,
    required String? caption,
  }) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final next = existing.copyWith(
      caption: Value(caption),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(photos).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'photo',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }

  Future<void> attachToDefectLocal({
    required String id,
    required String? defectId,
  }) async {
    final existing = await getById(id);
    if (existing == null) {
      return;
    }

    final next = existing.copyWith(
      defectId: Value(defectId),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(photos).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'photo',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [TimeEntries])
class TimeEntryDao extends DatabaseAccessor<AppDatabase>
    with _$TimeEntryDaoMixin {
  TimeEntryDao(super.db);

  Stream<List<TimeEntryRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(timeEntries)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.startTime)]))
        .watch();
  }

  Future<void> createLocal({
    required String tenantId,
    required String workOrderId,
    required String userId,
    required String type,
    required String startTime,
    String? endTime,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = _utcNowIso();
    final duration = endTime == null
        ? null
        : _minutesBetweenIso(startTime, endTime);
    final row = TimeEntriesCompanion.insert(
      id: id,
      tenantId: tenantId,
      workOrderId: workOrderId,
      userId: userId,
      type: type,
      startTime: startTime,
      endTime: Value(endTime),
      durationMinutes: Value(duration),
      notes: Value(notes),
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await transaction(() async {
      await into(timeEntries).insert(row);
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'time_entry',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'user_id': userId,
          'type': type,
          'start_time': startTime,
          'end_time': endTime,
          'duration_minutes': duration,
          'notes': notes,
        },
      );
    });
  }

  Future<void> updateLocal(TimeEntryRow row) async {
    final existing = await (select(
      timeEntries,
    )..where((table) => table.id.equals(row.id))).getSingleOrNull();
    if (existing == null) {
      return;
    }

    final next = row.copyWith(
      durationMinutes: Value(
        row.endTime == null
            ? row.durationMinutes
            : _minutesBetweenIso(row.startTime, row.endTime!),
      ),
      updatedAt: _utcNowIso(),
      version: existing.version + 1,
      syncStatus: 'pending',
    );

    await transaction(() async {
      await update(timeEntries).replace(next);
      await db.enqueueOutbox(
        tenantId: next.tenantId,
        entityType: 'time_entry',
        entityId: next.id,
        operation: 'update',
        payload: next.toJson(),
      );
    });
  }
}

@DriftAccessor(tables: [Materials, WorkOrderMaterials])
class MaterialDao extends DatabaseAccessor<AppDatabase>
    with _$MaterialDaoMixin {
  MaterialDao(super.db);

  Stream<List<MaterialRow>> watchActiveMaterials(String tenantId) {
    return (select(materials)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.deletedAt.isNull() &
                table.isActive.equals(true),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  Stream<List<WorkOrderMaterialRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(workOrderMaterials)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  Future<void> createWorkOrderMaterialLocal({
    required String tenantId,
    required String workOrderId,
    required String name,
    required double quantity,
    required String unit,
    String? materialId,
    String? notes,
  }) async {
    final selectedMaterial = materialId == null
        ? null
        : await (select(materials)..where(
                (table) =>
                    table.id.equals(materialId) &
                    table.tenantId.equals(tenantId) &
                    table.deletedAt.isNull() &
                    table.isActive.equals(true),
              ))
              .getSingleOrNull();

    if (materialId != null && selectedMaterial == null) {
      throw StateError('Material nicht gefunden.');
    }
    if (selectedMaterial?.stockQuantity != null) {
      final catalogUnit = selectedMaterial!.unit.trim().toLowerCase();
      final usageUnit = unit.trim().toLowerCase();
      if (catalogUnit != usageUnit) {
        throw StateError(
          'Materialbestand wird in ${selectedMaterial.unit} gefuehrt.',
        );
      }
      if (quantity > selectedMaterial.stockQuantity! + 0.000001) {
        throw StateError('Nicht genuegend Lagerbestand verfuegbar.');
      }
    }

    final id = _uuid.v4();
    final now = _utcNowIso();
    final row = WorkOrderMaterialsCompanion.insert(
      id: id,
      tenantId: tenantId,
      workOrderId: workOrderId,
      materialId: Value(materialId),
      name: name,
      quantity: quantity,
      unit: unit,
      notes: Value(notes),
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await transaction(() async {
      await into(workOrderMaterials).insert(row);
      if (selectedMaterial?.stockQuantity != null) {
        final nextMaterial = selectedMaterial!.copyWith(
          stockQuantity: Value(selectedMaterial.stockQuantity! - quantity),
          updatedAt: now,
          version: selectedMaterial.version + 1,
          syncStatus: 'pending',
        );
        await update(materials).replace(nextMaterial);
        await db.enqueueOutbox(
          tenantId: tenantId,
          entityType: 'material',
          entityId: nextMaterial.id,
          operation: 'update',
          payload: nextMaterial.toJson(),
        );
      }
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'work_order_material',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'material_id': materialId,
          'name': name,
          'quantity': quantity,
          'unit': unit,
          'notes': notes,
        },
      );
    });
  }
}

@DriftAccessor(tables: [ReportTemplates])
class ReportTemplateDao extends DatabaseAccessor<AppDatabase>
    with _$ReportTemplateDaoMixin {
  ReportTemplateDao(super.db);

  Future<ReportTemplateRow?> getDefault(String tenantId) {
    return (select(reportTemplates)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.isDefault.equals(true) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<ReportTemplateRow>> listActive(String tenantId) {
    return (select(reportTemplates)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.desc(table.isDefault),
            (table) => OrderingTerm.asc(table.name),
          ]))
        .get();
  }
}

@DriftAccessor(tables: [Reports])
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(super.db);

  Stream<List<ReportRow>> watchForWorkOrder(
    String tenantId,
    String workOrderId,
  ) {
    return (select(reports)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.workOrderId.equals(workOrderId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.generatedAt)]))
        .watch();
  }

  Future<String> createGeneratedLocal({
    required String tenantId,
    required String workOrderId,
    required String reportNumber,
    required String pdfLocalPath,
    String? customerNameSigned,
    bool signed = false,
  }) async {
    final id = _uuid.v4();
    final now = _utcNowIso();

    await transaction(() async {
      await into(reports).insert(
        ReportsCompanion.insert(
          id: id,
          tenantId: tenantId,
          workOrderId: workOrderId,
          reportNumber: reportNumber,
          status: signed ? 'signed' : 'generated',
          pdfLocalPath: Value(pdfLocalPath),
          generatedAt: Value(now),
          signedAt: Value(signed ? now : null),
          customerNameSigned: Value(customerNameSigned),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await db.workOrderDao.attachReportLocal(
        id: workOrderId,
        reportFileId: id,
      );
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'report',
        entityId: id,
        operation: 'create',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'report_number': reportNumber,
          'status': signed ? 'signed' : 'generated',
          'pdf_local_path': pdfLocalPath,
          'generated_at': now,
          'signed_at': signed ? now : null,
          'customer_name_signed': customerNameSigned,
        },
      );
      await db.enqueueOutbox(
        tenantId: tenantId,
        entityType: 'report',
        entityId: id,
        operation: 'upload_file',
        payload: {
          'id': id,
          'tenant_id': tenantId,
          'work_order_id': workOrderId,
          'pdf_local_path': pdfLocalPath,
          'mime_type': 'application/pdf',
        },
      );
    });

    return id;
  }
}

@DriftAccessor(tables: [OutboxEntries])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  OutboxDao(super.db);

  Stream<List<OutboxEntryRow>> watchPending(String tenantId) {
    return (select(outboxEntries)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.deletedAt.isNull() &
                table.status.isIn([
                  'pending',
                  'processing',
                  'failed',
                  'conflict',
                ]),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)]))
        .watch();
  }

  Stream<int> watchPendingCount(String tenantId) {
    return watchPending(tenantId).map((entries) => entries.length);
  }

  Future<List<OutboxEntryRow>> listPending(String tenantId, {int limit = 50}) {
    return (select(outboxEntries)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) &
                table.deletedAt.isNull() &
                table.status.isIn(['pending', 'failed']),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<void> markProcessing(String id) async {
    await _updateStatus(id, 'processing');
  }

  Future<void> markDone(String id) async {
    await _updateStatus(id, 'done');
  }

  Future<void> markFailed(String id, String message) async {
    final existing = await (select(
      outboxEntries,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      return;
    }

    await update(outboxEntries).replace(
      existing.copyWith(
        status: 'failed',
        attempts: existing.attempts + 1,
        lastAttemptAt: Value(_utcNowIso()),
        errorMessage: Value(message),
        updatedAt: _utcNowIso(),
        syncStatus: 'failed',
      ),
    );
  }

  Future<void> markConflict(String id, String message) async {
    final existing = await (select(
      outboxEntries,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      return;
    }

    await update(outboxEntries).replace(
      existing.copyWith(
        status: 'conflict',
        attempts: existing.attempts + 1,
        lastAttemptAt: Value(_utcNowIso()),
        errorMessage: Value(message),
        updatedAt: _utcNowIso(),
        syncStatus: 'conflict',
      ),
    );
  }

  Future<void> _updateStatus(String id, String status) async {
    final existing = await (select(
      outboxEntries,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      return;
    }

    await update(outboxEntries).replace(
      existing.copyWith(
        status: status,
        lastAttemptAt: Value(_utcNowIso()),
        updatedAt: _utcNowIso(),
        syncStatus: status == 'done' ? 'synced' : existing.syncStatus,
      ),
    );
  }
}

@DriftAccessor(tables: [SyncStates])
class SyncStateDao extends DatabaseAccessor<AppDatabase>
    with _$SyncStateDaoMixin {
  SyncStateDao(super.db);

  Stream<List<SyncStateRow>> watchForTenant(String tenantId) {
    return (select(syncStates)
          ..where((table) => table.tenantId.equals(tenantId))
          ..orderBy([(table) => OrderingTerm.asc(table.entityType)]))
        .watch();
  }
}
