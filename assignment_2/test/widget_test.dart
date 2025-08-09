// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:assignment_2/main.dart';

void main() {
  testWidgets('Home shows Math Fun and operation cards', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Math Fun!'), findsOneWidget);
    expect(find.text('Addition'), findsOneWidget);
    expect(find.text('Subtraction'), findsOneWidget);
    expect(find.text('Multiplication'), findsOneWidget);
    expect(find.text('Division'), findsOneWidget);
  });
}
