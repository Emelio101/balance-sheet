// ignore_for_file: prefer_const_constructors

import 'package:balance_sheet/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SettingsCubit(),
          child: MaterialApp(home: SettingsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
