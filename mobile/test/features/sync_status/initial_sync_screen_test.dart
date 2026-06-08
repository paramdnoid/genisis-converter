import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kaminfeger_mobile/core/routing/app_router.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/features/sync_status/presentation/initial_sync_screen.dart';
import '../../helpers/test_app.dart';

void main() {
  testWidgets('shows retryable error when initial sync fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseReadyProvider.overrideWith(
            (_) async => throw StateError('seed failed'),
          ),
        ],
        child: const _TestApp(),
      ),
    );

    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();

    expect(find.text('Initialer Sync fehlgeschlagen'), findsOneWidget);
    expect(find.textContaining('seed failed'), findsOneWidget);
    expect(find.text('Erneut versuchen'), findsOneWidget);
    expect(find.text('Dashboard erreicht'), findsNothing);
  });

  testWidgets('retry reruns failed initial sync and navigates on success', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    var attempts = 0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseReadyProvider.overrideWith((_) async {
            attempts += 1;
            if (attempts == 1) {
              throw StateError('temporary initial sync outage');
            }
            return database;
          }),
        ],
        child: const _TestApp(),
      ),
    );

    await tester.tap(find.text('Minimaldaten laden'));
    await tester.pumpAndSettle();

    expect(attempts, 1);
    expect(find.text('Erneut versuchen'), findsOneWidget);
    expect(
      find.textContaining('temporary initial sync outage'),
      findsOneWidget,
    );

    await tester.tap(find.text('Erneut versuchen'));
    await tester.pumpAndSettle();

    expect(attempts, 2);
    expect(find.text('Dashboard erreicht'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await database.close();
  });
}

final class _TestApp extends StatelessWidget {
  const _TestApp();

  @override
  Widget build(BuildContext context) {
    return localizedRouterTestApp(router: _router());
  }

  GoRouter _router() {
    return GoRouter(
      initialLocation: AppRoutes.initialSync,
      routes: [
        GoRoute(
          path: AppRoutes.initialSync,
          builder: (context, state) => const InitialSyncScreen(),
        ),
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Dashboard erreicht'))),
        ),
      ],
    );
  }
}
