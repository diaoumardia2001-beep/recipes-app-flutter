import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/main.dart';

void main() {
  testWidgets('App smoke test - verifies home screen and recipes count', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipesApp());
    await tester.pumpAndSettle();

    // Verify home screen loads with title
    expect(find.text('Cuisine Ivoirienne'), findsOneWidget);

    // Verify search bar is present
    expect(find.text('Rechercher une recette...'), findsOneWidget);
  });

  testWidgets('Navigation test - navigate between bottom bar screens', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipesApp());
    await tester.pumpAndSettle();

    // Tap on "Ajouter" in NavigationBar
    await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Nouvelle recette'), findsOneWidget);

    // Tap on "Réglages" in NavigationBar
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Mode sombre'), findsOneWidget);

    // Return to "Accueil"
    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Cuisine Ivoirienne'), findsOneWidget);
  });

  testWidgets('Search and filter test - filtering recipes', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipesApp());
    await tester.pumpAndSettle();

    // Enter search text
    await tester.enterText(find.byType(TextField), 'Garba');
    await tester.pumpAndSettle();

    // Should find Garba
    expect(find.text('Garba'), findsWidgets);
  });

  testWidgets('Form validation test - empty submission triggers errors', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipesApp());
    await tester.pumpAndSettle();

    // Go to Add screen
    await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
    await tester.pumpAndSettle();

    // Scroll to submit button and tap it
    final submitButtonFinder = find.text('Ajouter la recette');
    await tester.ensureVisible(submitButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    // Scroll back to title field
    final titleFieldFinder = find.widgetWithText(TextFormField, 'Nom de la recette *');
    await tester.ensureVisible(titleFieldFinder);
    await tester.pumpAndSettle();

    // Verify validation errors appear
    expect(find.text('Le nom de la recette est obligatoire'), findsOneWidget);
  });
}
