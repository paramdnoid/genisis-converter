import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kaminfeger_mobile/app.dart';
import 'package:kaminfeger_mobile/core/routing/app_router.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late ConnectivityPlatform originalConnectivityPlatform;

  setUp(() {
    originalConnectivityPlatform = ConnectivityPlatform.instance;
    ConnectivityPlatform.instance = _OfflineConnectivityPlatform();
  });

  tearDown(() {
    ConnectivityPlatform.instance = originalConnectivityPlatform;
  });

  testWidgets('offline technician can reach seeded work orders', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: KaminfegerApp(routerConfig: createAppRouter()),
      ),
    );

    await tester.tap(find.text('Zur Anmeldung'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Demo-Sitzung öffnen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Heute'));

    expect(find.text('Heute'), findsOneWidget);
    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Alle Aufträge'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Alle Aufträge'));
    await tester.pumpAndSettle();

    expect(find.text('Aufträge'), findsWidgets);
    expect(find.text('Jahreskontrolle Cheminée'), findsOneWidget);
    expect(find.text('Reinigung Abgasanlage'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }

  expect(finder, findsOneWidget);
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
