part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.totalBalance = 0.0,
    this.monthlyIncome = 0.0,
    this.monthlyExpenses = 0.0,
    this.savingsRate = 0.0,
  });

  final DashboardStatus status;
  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpenses;
  final double savingsRate;

  @override
  List<Object> get props {
    return [
      status,
      totalBalance,
      monthlyIncome,
      monthlyExpenses,
      savingsRate,
    ];
  }

  DashboardState copyWith({
    DashboardStatus? status,
    double? totalBalance,
    double? monthlyIncome,
    double? monthlyExpenses,
    double? savingsRate,
  }) {
    return DashboardState(
      status: status ?? this.status,
      totalBalance: totalBalance ?? this.totalBalance,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      savingsRate: savingsRate ?? this.savingsRate,
    );
  }
}
