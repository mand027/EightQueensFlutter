// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:eight_queens/PastBoard.dart';
import 'package:eight_queens/ProblamSolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eight_queens/main.dart';

void main() {
  testWidgets('Test increase N', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('8'), findsNothing);
    expect(find.text('9'), findsOneWidget);
  });

  testWidgets("test decrease N", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('8'), findsOneWidget);
    expect(find.text('7'), findsNothing);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('8'), findsNothing);
    expect(find.text('7'), findsOneWidget);
  });
}
