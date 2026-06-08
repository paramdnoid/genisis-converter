import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/work_orders/presentation/work_order_list_screen.dart';
import '../../helpers/test_app.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('filters local work orders by status without sync', (
    tester,
  ) async {
    await database.workOrderDao.startLocal(
      id: DevelopmentSeed.workOrderInspectionId,
      userId: DevelopmentSeed.technicianUserId,
    );

    await _pumpList(tester, database);

    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'In Arbeit'));
    await tester.pumpAndSettle();

    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('Reinigung Abgasanlage'), findsNothing);

    await tester.tap(find.widgetWithText(FilterChip, 'Geplant'));
    await tester.pumpAndSettle();

    expect(find.text('Jahreskontrolle Cheminée'), findsNothing);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await _disposeList(tester);
  });

  testWidgets('combines local search and status filters with reset', (
    tester,
  ) async {
    await database.workOrderDao.startLocal(
      id: DevelopmentSeed.workOrderInspectionId,
      userId: DevelopmentSeed.technicianUserId,
    );

    await _pumpList(tester, database);

    await tester.tap(find.widgetWithText(FilterChip, 'In Arbeit'));
    await tester.enterText(find.byType(TextField), 'WO-2026-0002');
    await tester.pumpAndSettle();

    expect(find.text('Keine passenden Aufträge'), findsOneWidget);
    expect(find.text('Jahreskontrolle Cheminée'), findsNothing);
    expect(find.text('Reinigung Abgasanlage'), findsNothing);

    await tester.tap(find.text('Filter zurücksetzen'));
    await tester.pumpAndSettle();

    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await _disposeList(tester);
  });
}

Future<void> _pumpList(WidgetTester tester, AppDatabase database) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        databaseReadyProvider.overrideWith((_) async => database),
      ],
      child: localizedTestApp(home: const WorkOrderListScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _disposeList(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
}
