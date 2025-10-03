import 'package:balance_sheet/settings/cubit/settings_cubit.dart';
import 'package:balance_sheet/settings/widgets/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const SettingsBody(),
    );
  }
}
