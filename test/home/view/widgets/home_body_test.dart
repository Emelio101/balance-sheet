import 'package:balance_sheet/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => HomeCubit(),
          child: const MaterialApp(home: HomeBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
