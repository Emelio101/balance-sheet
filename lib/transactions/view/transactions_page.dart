import 'package:balance_sheet/transactions/cubit/transactions_cubit.dart';
import 'package:balance_sheet/transactions/widgets/transactions_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsCubit()..loadTransactions(),
      child: const TransactionsBody(),
    );
  }
}
