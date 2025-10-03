import 'package:equatable/equatable.dart';

enum TransactionType { income, expense }

class TransactionModel extends Equatable {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.description = '',
  });

  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;
  final String description;

  @override
  List<Object> get props {
    return [
      id,
      title,
      amount,
      type,
      category,
      date,
      description,
    ];
  }

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionType? type,
    String? category,
    DateTime? date,
    String? description,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}
