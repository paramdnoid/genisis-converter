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
  static const workOrderInspectionId = '66666666-6666-4666-8666-666666666666';
  static const workOrderCleaningId = '77777777-7777-4777-8777-777777777777';
  static const checklistTemplateId = '99999999-9999-4999-8999-999999999999';
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
    ReportDao,
    OutboxDao,
    SyncStateDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
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
    await into(outboxEntries).insert(
      OutboxEntriesCompanion.insert(
        id: _uuid.v4(),
        tenantId: tenantId,
        entityType: entityType,
        entityId: entityId,
        operation: operation,
        payloadJson: jsonEncode(payload),
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
      'work_order' => 'work_orders',
      'checklist_answer' => 'checklist_answers',
      'measurement' => 'measurements',
      'defect' => 'defects',
      'photo' => 'photos',
      'time_entry' => 'time_entries',
      'work_order_material' => 'work_order_materials',
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
          id: 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb',
          tenantId: DevelopmentSeed.tenantId,
          sku: const Value('REIN-001'),
          name: 'Reinigungspauschale Kleinauftrag',
          unit: 'Stueck',
          defaultPrice: const Value(85),
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

  Stream<List<CustomerRow>> watchActive(String tenantId) {
    return (select(customers)
          ..where(
            (table) =>
                table.tenantId.equals(tenantId) & table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.displayName)]))
        .watch();
  }
}

@DriftAccessor(tables: [CustomerObjects])
class ObjectDao extends DatabaseAccessor<AppDatabase> with _$ObjectDaoMixin {
  ObjectDao(super.db);

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
}

@DriftAccessor(tables: [Installations])
class InstallationDao extends DatabaseAccessor<AppDatabase>
    with _$InstallationDaoMixin {
  InstallationDao(super.db);

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

@DriftAccessor(
  tables: [
    WorkOrders,
    Customers,
    CustomerObjects,
    Installations,
    TimeEntries,
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
                table.status.isIn(['pending', 'processing', 'failed']),
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
