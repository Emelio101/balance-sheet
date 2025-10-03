part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.currency = 'ZMW',
    this.currencySymbol = r'K',
  });

  final bool isDarkMode;
  final String currency;
  final String currencySymbol;

  @override
  List<Object> get props => [isDarkMode, currency, currencySymbol];

  SettingsState copyWith({
    bool? isDarkMode,
    String? currency,
    String? currencySymbol,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
    );
  }
}
