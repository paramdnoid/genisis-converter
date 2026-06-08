import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/search/presentation/search_screen.dart';
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

  test('search provider finds all local result groups offline', () async {
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        databaseReadyProvider.overrideWith((_) async => database),
      ],
    );
    addTearDown(container.dispose);

    final byOrder = await container.read(
      searchResultsProvider('WO-2026-0001').future,
    );
    final byCustomer = await container.read(
      searchResultsProvider('Familie Keller').future,
    );
    final byCity = await container.read(searchResultsProvider('Uster').future);
    final byInstallation = await container.read(
      searchResultsProvider('Rueegg').future,
    );

    expect(
      byOrder.map((result) => result.groupKey),
      contains(SearchResultGroup.orders),
    );
    expect(byOrder.single.title, 'Jahreskontrolle Cheminée');
    expect(
      byCustomer.map((result) => result.groupKey),
      contains(SearchResultGroup.customers),
    );
    expect(
      byCity.map((result) => result.groupKey),
      contains(SearchResultGroup.objects),
    );
    expect(
      byInstallation.map((result) => result.groupKey),
      contains(SearchResultGroup.installations),
    );
    expect(byInstallation.single.subtitle, 'fireplace');
  });

  testWidgets('search screen debounces local queries and shows results', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          searchResultsProvider.overrideWith((ref, query) {
            if (query == 'Rueegg') {
              return const [
                SearchResult(
                  groupKey: SearchResultGroup.installations,
                  title: 'Rueegg RIII 45',
                  subtitle: 'fireplace',
                  route: '/installations/installation-1',
                ),
              ];
            }
            return const [];
          }),
        ],
        child: localizedTestApp(home: const SearchScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Keine Treffer'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Rueegg');
    await tester.pump(const Duration(milliseconds: 251));
    await tester.pump();

    expect(find.text('Rueegg RIII 45'), findsOneWidget);
    expect(find.text('Anlagen · fireplace'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 251));
  });
}
