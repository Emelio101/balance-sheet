import 'package:balance_sheet/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DashboardBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => DashboardCubit(),
          child: const MaterialApp(home: DashboardBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
