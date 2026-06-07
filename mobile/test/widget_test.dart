import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaminfeger_mobile/app.dart';

void main() {
  testWidgets('opens splash screen and navigates to dashboard', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: KaminfegerApp()));

    expect(find.text('Kaminfeger Techniker'), findsOneWidget);
    expect(find.text('Zur Anmeldung'), findsOneWidget);

    await tester.tap(find.text('Zur Anmeldung'));
    await tester.pumpAndSettle();

    expect(find.text('Technikerzugang'), findsOneWidget);
    expect(find.text('Demo-Sitzung öffnen'), findsOneWidget);

    await tester.tap(find.text('Demo-Sitzung öffnen'));
    await tester.pumpAndSettle();

    expect(find.text('Heute'), findsOneWidget);
    expect(find.text('Nächster Auftrag'), findsOneWidget);
  });
}
