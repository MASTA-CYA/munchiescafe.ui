import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchies_cafe/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    // MessageService loads saved messages on start-up; give it an empty list.
    SharedPreferences.setMockInitialValues({
      'MESSAGES_KEY': jsonEncode('[]'),
    });
  });

  testWidgets('App starts on the sign-in page', (WidgetTester tester) async {
    // Use a typical phone screen (360 x 800 logical pixels).
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const Main());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Munchies Café'), findsOneWidget);
    expect(find.text('Treats for your sweet tooth'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
