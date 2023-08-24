import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trip_brain_app/trip_brain_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Initial loading is visible', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const TripBrainApp());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Just a moment...'), findsOneWidget);
    });
  });
}
