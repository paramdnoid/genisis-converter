import 'package:drift/native.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaminfeger_mobile/app.dart';
import 'package:kaminfeger_mobile/core/routing/app_router.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';

void main() {
  late ConnectivityPlatform originalConnectivityPlatform;

  setUp(() {
    originalConnectivityPlatform = ConnectivityPlatform.instance;
  });

  tearDown(() {
    ConnectivityPlatform.instance = originalConnectivityPlatform;
  });

  testWidgets('starts and reaches dashboard without internet', (tester) async {
    ConnectivityPlatform.instance = _OfflineConnectivityPlatform();
    final database = await _pumpApp(tester);

    expect(find.text('Kaminfeger Techniker'), findsOneWidget);
    expect(find.text('Zur Anmeldung'), findsOneWidget);

    await tester.tap(find.text('Zur Anmeldung'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Demo-Sitzung öffnen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();

    expect(find.text('Heute'), findsOneWidget);
    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);

    await _disposeApp(tester, database);
  });

  testWidgets('opens splash screen and navigates to dashboard', (tester) async {
    final database = await _pumpApp(tester);

    expect(find.text('Kaminfeger Techniker'), findsOneWidget);
    expect(find.text('Zur Anmeldung'), findsOneWidget);

    await tester.tap(find.text('Zur Anmeldung'));
    await tester.pumpAndSettle();

    expect(find.text('Technikerzugang'), findsOneWidget);
    expect(find.text('Demo-Sitzung öffnen'), findsOneWidget);

    await tester.tap(find.text('Demo-Sitzung öffnen'));
    await tester.pumpAndSettle();

    expect(find.text('Initialer Sync'), findsOneWidget);
    expect(find.text('Minimaldaten laden'), findsOneWidget);

    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();

    expect(find.text('Heute'), findsOneWidget);
    expect(find.text('Nächster Auftrag'), findsOneWidget);
    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('WO-2026-0001 · 08:30-10:00'), findsOneWidget);

    await _disposeApp(tester, database);
  });

  testWidgets('opens local work order list with search and filters', (
    tester,
  ) async {
    final database = await _pumpApp(tester);

    await tester.tap(find.text('Zur Anmeldung'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Demo-Sitzung öffnen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Alle Aufträge'));
    await tester.pumpAndSettle();

    expect(find.text('Aufträge'), findsWidgets);
    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'WO-2026-0002');
    await tester.pumpAndSettle();

    expect(find.text('Jahreskontrolle Cheminée'), findsNothing);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Jahreskontrolle Cheminée'));
    await tester.pumpAndSettle();

    expect(find.text('Auftragsdetail'), findsOneWidget);
    expect(find.text('Familie Keller'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Im Ried 7, 8610 Uster'),
      find.byType(ListView),
      const Offset(0, -240),
    );
    expect(find.text('Im Ried 7, 8610 Uster'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Rueegg RIII 45'),
      find.byType(ListView),
      const Offset(0, -240),
    );
    expect(find.text('Rueegg RIII 45'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Messungen'),
      find.byType(ListView),
      const Offset(0, -240),
    );
    await tester.tap(find.text('Messungen'));
    await tester.pumpAndSettle();

    expect(find.text('Messungen'), findsOneWidget);
    expect(find.text('Messwert erfassen'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '18');
    await tester.tap(find.text('Messwert speichern'));
    await tester.pumpAndSettle();

    expect(find.text('Messwert lokal gespeichert.'), findsOneWidget);
    expect(find.text('18,0 ppm'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Checkliste'));
    await tester.pumpAndSettle();

    expect(find.text('Checkliste'), findsOneWidget);
    expect(
      find.text('Feuerstaette frei von sichtbaren Maengeln?'),
      findsOneWidget,
    );
    expect(find.text('Allgemeine Bemerkung'), findsOneWidget);
    expect(find.text('1/6'), findsNothing);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Lokal gespeichert'), findsWidgets);

    await _disposeApp(tester, database);
  });
}

final class _OfflineConnectivityPlatform extends ConnectivityPlatform {
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return [ConnectivityResult.none];
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return Stream.value([ConnectivityResult.none]);
  }
}

Future<AppDatabase> _pumpApp(WidgetTester tester) async {
  final database = AppDatabase.forTesting(NativeDatabase.memory());

  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
      child: KaminfegerApp(routerConfig: createAppRouter()),
    ),
  );

  return database;
}

Future<void> _disposeApp(WidgetTester tester, AppDatabase database) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await database.close();
  await tester.pump(const Duration(milliseconds: 1));
}
