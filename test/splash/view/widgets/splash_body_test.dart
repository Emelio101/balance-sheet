// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:balance_sheet/splash/splash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SplashCubit(),
          child: MaterialApp(home: SplashBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
