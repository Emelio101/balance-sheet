import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void updateThemePreference(bool isDarkMode) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  void updateCurrency(String currencyCode, String currencySymbol) {
    emit(
      state.copyWith(
        currency: currencyCode,
        currencySymbol: currencySymbol,
      ),
    );
  }
}
