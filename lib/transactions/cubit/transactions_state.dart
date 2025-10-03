part of 'transactions_cubit.dart';

enum TransactionsStatus { initial, loading, success, failure }

class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
  });

  final TransactionsStatus status;
  final List<TransactionModel> transactions;

  @override
  List<Object> get props => [status, transactions];

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionModel>? transactions,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }
}
