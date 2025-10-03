import 'package:auth_repo/auth_repo.dart';
import 'package:balance_sheet/app/theme/theme_cubit.dart';
import 'package:balance_sheet/dashboard/cubit/dashboard_cubit.dart';
import 'package:balance_sheet/home/cubit/home_cubit.dart';
import 'package:balance_sheet/home/view/home_page.dart';
import 'package:balance_sheet/settings/cubit/settings_cubit.dart';
import 'package:balance_sheet/splash/view/splash_page.dart';
import 'package:balance_sheet/transactions/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit()..loadDashboardData(),
        ),
        BlocProvider(
          create: (context) => TransactionsCubit()..loadTransactions(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(authRepo: AuthRepo()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Balance Sheet',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: state.mode,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
