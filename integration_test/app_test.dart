import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trip_brain_app/firebase_options.dart';
import 'package:trip_brain_app/trip_brain_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  group('end-to-end test', () {
    testWidgets('App works till suggestion', (tester) async {
      await tester.pumpWidget(const TripBrainApp());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Just a moment...'), findsOneWidget);

      await tester.pumpAndSettle();

      final suggestionField = find.byKey(const Key("travelToTextField"));
      final suggestButton = find.text('Suggest');

      expect(suggestionField, findsOneWidget);
      expect(suggestButton, findsOneWidget);

      await tester.enterText(suggestionField, "flutter");
      await tester.tap(suggestButton);
      await tester.pumpAndSettle();

      final nesxtButton = find.text("Next Step");

      await tester.tap(nesxtButton);
    });
  });
}
