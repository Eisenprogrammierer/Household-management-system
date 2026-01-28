import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('App starts and shows text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello CI/CD!'), findsOneWidget);
    expect(find.text('Тестовый проект'), findsOneWidget);
  });
}