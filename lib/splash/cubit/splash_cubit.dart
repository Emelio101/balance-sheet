import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial()) {
    _startTimer();
  }

  void _startTimer() {
    // Wait for 3 seconds then emit completed state
    Timer(const Duration(seconds: 3), () {
      emit(const SplashCompleted());
    });
  }
}
