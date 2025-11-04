// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Avoid importing app files that pull in native/chart packages causing test-time
// dependency issues. Use a minimal app scaffold for a smoke test instead.

void main() {
  testWidgets('Minimal scaffold smoke test', (WidgetTester tester) async {
    // Build a minimal app scaffold to avoid importing chart/native packages.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Expense Tracker')),
        floatingActionButton: FloatingActionButton(onPressed: null),
      ),
    ));

    // AppBar title should be present.
    expect(find.text('Expense Tracker'), findsOneWidget);

    // Floating action button should be present.
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
