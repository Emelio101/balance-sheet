import 'package:balance_sheet/splash/cubit/cubit.dart';
import 'package:balance_sheet/splash/widgets/splash_body.dart';
import 'package:flutter/material.dart';

/// {@template splash_page}
/// A description for SplashPage
/// {@endtemplate}
class SplashPage extends StatelessWidget {
  /// {@macro splash_page}
  const SplashPage({super.key});

  /// The static route for SplashPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Scaffold(
        body: SafeArea(child: SplashView()),
      ),
    );
  }
}

/// {@template splash_view}
/// Displays the Body of SplashView
/// {@endtemplate}
class SplashView extends StatelessWidget {
  /// {@macro splash_view}
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashBody();
  }
}
