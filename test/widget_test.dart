import 'package:flutter_test/flutter_test.dart';
import 'package:puzzelapp/main.dart'; // Zorg dat dit de correcte import is

void main() {
  testWidgets('PuzzelApp heeft de titel "Puzzel App"', (
    WidgetTester tester,
  ) async {
    // Bouw de app op in de testomgeving.
    await tester.pumpWidget(PuzzelApp());

    // Controleer of de titel "Puzzel App" wordt weergegeven.
    expect(find.text('Puzzel App'), findsOneWidget);
  });
}
