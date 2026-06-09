import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/materials/presentation/material_screen.dart';

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

  testWidgets('shows local stock for tracked catalog materials', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          databaseReadyProvider.overrideWith((_) async => database),
        ],
        child: localizedTestApp(
          home: const MaterialScreen(
            workOrderId: DevelopmentSeed.workOrderInspectionId,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Lagerbestand'), findsOneWidget);
    expect(find.text('Reinigungspauschale Kleinauftrag'), findsOneWidget);
    expect(find.textContaining('Bestand:'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
