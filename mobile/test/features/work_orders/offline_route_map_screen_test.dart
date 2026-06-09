import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/work_orders/presentation/offline_route_map_screen.dart';

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

  testWidgets("renders today's local route as an offline map", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          databaseReadyProvider.overrideWith((_) async => database),
        ],
        child: localizedTestApp(home: const OfflineRouteMapScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Offline-Karte'), findsWidgets);
    expect(find.textContaining('2 Stopp'), findsOneWidget);
    expect(find.byKey(const Key('offline-route-map-canvas')), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('WO-2026-0001'), findsOneWidget);
    expect(find.text('WO-2026-0002'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
