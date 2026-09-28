import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipesApp());
    await tester.pumpAndSettle();
    // Verify home screen loads
    expect(find.text('🇨🇮 Cuisine Ivoirienne'), findsOneWidget);
  });
}
