import 'package:balance_sheet/models/transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(const TransactionsState());

  void loadTransactions() {
    emit(state.copyWith(status: TransactionsStatus.loading));

    // Sample data - matching the dashboard calculations
    final transactions = [
      TransactionModel(
        id: '1',
        title: 'Groceries',
        amount: 85.50,
        type: TransactionType.expense,
        category: 'Food',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransactionModel(
        id: '2',
        title: 'Salary',
        amount: 3500,
        type: TransactionType.income,
        category: 'Salary',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      TransactionModel(
        id: '3',
        title: 'Rent',
        amount: 1200,
        type: TransactionType.expense,
        category: 'Housing',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      TransactionModel(
        id: '4',
        title: 'Restaurant',
        amount: 314.50,
        type: TransactionType.expense,
        category: 'Food',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TransactionModel(
        id: '5',
        title: 'Gas',
        amount: 150,
        type: TransactionType.expense,
        category: 'Transport',
        date: DateTime.now().subtract(const Duration(days: 4)),
      ),
      TransactionModel(
        id: '6',
        title: 'Electricity Bill',
        amount: 100,
        type: TransactionType.expense,
        category: 'Transport',
        date: DateTime.now().subtract(const Duration(days: 6)),
      ),
      TransactionModel(
        id: '7',
        title: 'Entertainment',
        amount: 150,
        type: TransactionType.expense,
        category: 'Other',
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];

    emit(
      state.copyWith(
        status: TransactionsStatus.success,
        transactions: transactions,
      ),
    );
  }

  void addTransaction(TransactionModel transaction) {
    final updatedTransactions = [...state.transactions, transaction];
    emit(state.copyWith(transactions: updatedTransactions));
  }

  void removeTransaction(String id) {
    final updatedTransactions = state.transactions
        .where((transaction) => transaction.id != id)
        .toList();
    emit(state.copyWith(transactions: updatedTransactions));
  }

  // Calculate totals from actual transactions
  double get totalIncome {
    return state.transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get totalExpenses {
    return state.transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get balance {
    return totalIncome - totalExpenses;
  }

  double get savingsRate {
    if (totalIncome == 0) return 0;
    return ((totalIncome - totalExpenses) / totalIncome) * 100;
  }

  // Get expenses by category for charts
  Map<String, double> get expensesByCategory {
    final categoryTotals = <String, double>{};

    for (final transaction in state.transactions) {
      if (transaction.type == TransactionType.expense) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.amount;
      }
    }

    return categoryTotals;
  }
}
