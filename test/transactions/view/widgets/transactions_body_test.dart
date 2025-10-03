// ignore_for_file: prefer_const_constructors

import 'package:balance_sheet/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionsBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => TransactionsCubit(),
          child: MaterialApp(home: TransactionsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
