import 'dart:async';

import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.authRepo}) : super(const ThemeState()) {
    unawaited(_loadTheme());
  }

  final AuthRepo authRepo;

  Future<void> _loadTheme() async {
    try {
      final themeIndex = await authRepo.getTheme();
      final themeMode = themeIndex == 0 ? ThemeMode.light : ThemeMode.dark;
      emit(state.copyWith(mode: themeMode));
    } on Exception {
      // Fallback to light theme
      emit(state.copyWith(mode: ThemeMode.light));
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state.mode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    final themeIndex = newMode == ThemeMode.light ? 0 : 1;
    await authRepo.setTheme(themeIndex);

    emit(state.copyWith(mode: newMode));
  }

  Future<void> setTheme(ThemeMode mode) async {
    final themeIndex = mode == ThemeMode.light ? 0 : 1;
    await authRepo.setTheme(themeIndex);
    emit(state.copyWith(mode: mode));
  }
}
