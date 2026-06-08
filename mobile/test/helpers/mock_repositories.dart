import 'package:kaminfeger_mobile/domain/repositories/checklist_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/customer_object_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/customer_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/defect_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/installation_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/material_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/measurement_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/photo_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/report_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/time_entry_repository.dart';
import 'package:kaminfeger_mobile/domain/repositories/work_order_repository.dart';
import 'package:mocktail/mocktail.dart';

final class MockChecklistRepository extends Mock
    implements ChecklistRepository {}

final class MockCustomerObjectRepository extends Mock
    implements CustomerObjectRepository {}

final class MockCustomerRepository extends Mock implements CustomerRepository {}

final class MockDefectRepository extends Mock implements DefectRepository {}

final class MockInstallationRepository extends Mock
    implements InstallationRepository {}

final class MockMaterialRepository extends Mock implements MaterialRepository {}

final class MockMeasurementRepository extends Mock
    implements MeasurementRepository {}

final class MockPhotoRepository extends Mock implements PhotoRepository {}

final class MockReportRepository extends Mock implements ReportRepository {}

final class MockTimeEntryRepository extends Mock
    implements TimeEntryRepository {}

final class MockWorkOrderRepository extends Mock
    implements WorkOrderRepository {}
