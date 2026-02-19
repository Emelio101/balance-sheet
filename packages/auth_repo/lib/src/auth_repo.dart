import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template auth_repo}
/// Repository for managing authentication and user preferences.
/// {@endtemplate}
class AuthRepo {
  /// {@macro auth_repo}
  AuthRepo() {
    unawaited(_init());
  }

  late SharedPreferences _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Shared preferences keys
  final String _keyTheme = 'theme';
  final _themeController = StreamController<int>();

  /// The current app theme
  Stream<int> get theme async* {
    await _init(); // Ensure prefs is initialized
    final appTheme = await getTheme();
    yield appTheme;
    yield* _themeController.stream;
  }

  /// Get the app theme
  Future<int> getTheme() async {
    await _init(); // Ensure prefs is initialized
    return _prefs.getInt(_keyTheme) ?? 0;
  }

  /// Set the app theme
  Future<void> setTheme(int themeMode) async {
    await _init(); // Ensure prefs is initialized
    await _prefs.setInt(_keyTheme, themeMode);
    _themeController.add(themeMode);
  }

  /// Dispose the stream controller when done
  Future<void> dispose() async {
    await _themeController.close();
  }
}
