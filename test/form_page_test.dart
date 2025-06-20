// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import the page we want to test
import 'package:hello_world/form_page.dart';

void main() {
  // Define a new test case
  testWidgets('Form page should display a text field and a submit button', (
    WidgetTester tester,
  ) async {
    // 1. Build our FormPage widget.
    // We need to wrap it in a MaterialApp because it uses Material components
    // like Scaffold and needs things like theme data to render properly.
    await tester.pumpWidget(const MaterialApp(home: FormPage()));

    // 2. Find widgets on the screen.
    final textField = find.byType(TextField);
    final button = find.byType(ElevatedButton);

    // 3. Verify that our widgets are found.
    expect(textField, findsOneWidget);
    expect(button, findsOneWidget);
  });

  testWidgets('Submitting the form clears the text field', (
    WidgetTester tester,
  ) async {
    // 1. Build the FormPage widget.
    await tester.pumpWidget(const MaterialApp(home: FormPage()));

    // 2. Define finders for the widgets we need to interact with.
    final textFieldFinder = find.byType(TextField);
    final buttonFinder = find.byType(ElevatedButton);

    // 3. Enter text into the TextField.
    await tester.enterText(textFieldFinder, 'Hello, Test');

    // 4. Tap the submit button.
    await tester.tap(buttonFinder);

    // 5. Rebuild the widget to reflect the state change (the text clearing).
    await tester.pump();

    // 6. Verify that the TextField is now empty by checking that the
    //    original text can no longer be found.
    expect(find.text('Hello, Test'), findsNothing);
  });
}
