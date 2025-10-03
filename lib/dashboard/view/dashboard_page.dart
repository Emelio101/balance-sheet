import 'package:balance_sheet/dashboard/cubit/dashboard_cubit.dart';
import 'package:balance_sheet/dashboard/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit()..loadDashboardData(),
      child: const DashboardBody(),
    );
  }
}
