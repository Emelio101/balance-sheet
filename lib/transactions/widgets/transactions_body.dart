import 'package:balance_sheet/models/transaction_model.dart';
import 'package:balance_sheet/settings/cubit/settings_cubit.dart';
import 'package:balance_sheet/transactions/cubit/transactions_cubit.dart';
import 'package:balance_sheet/transactions/widgets/add_transaction_dialog.dart';
import 'package:balance_sheet/transactions/widgets/transaction_details_dialog.dart';
import 'package:balance_sheet/transactions/widgets/transaction_item.dart';
import 'package:balance_sheet/widgets/app_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                title: const Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.filter_list_rounded),
                    onPressed: () {
                      showInfoSnackBar(
                        context,
                        message: 'Filter feature coming soon!',
                      );
                    },
                  ),
                ],
              ),
              body: _buildBody(state, context, settingsState.currencySymbol),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: context.read<TransactionsCubit>(),
                      child: const AddTransactionDialog(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add'),
                elevation: 4,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(
    TransactionsState state,
    BuildContext context,
    String currencySymbol,
  ) {
    switch (state.status) {
      case TransactionsStatus.initial:
      case TransactionsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case TransactionsStatus.success:
        if (state.transactions.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    size: 64,
                    color: Colors.blue.shade300,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'No transactions yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to add your first transaction',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Group transactions by date
        final groupedTransactions = _groupTransactionsByDate(
          state.transactions,
        );

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: groupedTransactions.length,
          itemBuilder: (context, index) {
            final dateGroup = groupedTransactions[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 4,
                  ),
                  child: Text(
                    dateGroup['date'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                ...((dateGroup['transactions'] as List<TransactionModel>).map((
                  transaction,
                ) {
                  return TransactionItem(
                    transaction: transaction,
                    currencySymbol: currencySymbol,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<TransactionsCubit>(),
                          child: TransactionDetailsDialog(
                            transaction: transaction,
                            currencySymbol: currencySymbol,
                          ),
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      context.read<TransactionsCubit>().removeTransaction(
                        transaction.id,
                      );

                      showSuccessSnackBar(
                        context,
                        message: '${transaction.title} deleted successfully',
                      );
                    },
                  );
                }).toList()),
                const SizedBox(height: 8),
              ],
            );
          },
        );
      case TransactionsStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Colors.red.shade300,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Failed to load transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please try again',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TransactionsCubit>().loadTransactions();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  List<Map<String, dynamic>> _groupTransactionsByDate(
    List<TransactionModel> transactions,
  ) {
    final grouped = <String, List<TransactionModel>>{};

    for (final transaction in transactions) {
      final dateKey = _getDateKey(transaction.date);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = <TransactionModel>[]; // Properly typed list
      }
      grouped[dateKey]!.add(transaction);
    }

    return grouped.entries.map((entry) {
      return {
        'date': entry.key,
        'transactions': entry.value,
      };
    }).toList();
  }

  String _getDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}
