// household-management-system/test/core/widgets/app_button_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:household_management_system/core/widgets/app_widgets.dart';

void main() {
  testWidgets('AppButton renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Test',
            onPressed: () {},
          ),
        ),
      ),
    );
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('AppButton shows loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Test',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppButton disabled when loading', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Test',
            onPressed: () { pressed = true; },
            isLoading: true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ElevatedButton));
    expect(pressed, isFalse);
  });
}
