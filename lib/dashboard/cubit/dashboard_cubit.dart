import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void loadDashboardData() {
    emit(state.copyWith(status: DashboardStatus.loading));

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      emit(
        state.copyWith(
          status: DashboardStatus.success,
          totalBalance: 2500,
          monthlyIncome: 3500,
          monthlyExpenses: 1000,
          savingsRate: 71.43,
        ),
      );
    });
  }

  void refreshData() {
    loadDashboardData();
  }
}
