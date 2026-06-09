import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kaminfeger_mobile/core/routing/app_router.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/installations/presentation/installation_list_screen.dart';

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

  testWidgets('opens scan route from installation list action', (tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.installations,
      routes: [
        GoRoute(
          path: AppRoutes.installations,
          builder: (context, state) => const InstallationListScreen(),
        ),
        GoRoute(
          path: AppRoutes.installationScan,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Scan route reached'))),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          databaseReadyProvider.overrideWith((_) async => database),
        ],
        child: localizedRouterTestApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rueegg RIII 45'), findsOneWidget);
    expect(find.byTooltip('QR-/Barcode scannen'), findsOneWidget);

    await tester.tap(find.byTooltip('QR-/Barcode scannen'));
    await tester.pumpAndSettle();

    expect(find.text('Scan route reached'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
