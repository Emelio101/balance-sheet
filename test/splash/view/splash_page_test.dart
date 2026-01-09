// ignore_for_file: prefer_const_constructors

import 'package:balance_sheet/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashPage', () {
    group('route', () {
      test('is routable', () {
        expect(SplashPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders SplashView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SplashPage()));
      expect(find.byType(SplashView), findsOneWidget);
    });
  });
}
