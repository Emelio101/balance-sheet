part of 'splash_cubit.dart';

/// {@template splash}
/// SplashState description
/// {@endtemplate}
class SplashState extends Equatable {
  /// {@macro splash}
  const SplashState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current SplashState with property changes
  SplashState copyWith({
    String? customProperty,
  }) {
    return SplashState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template splash_initial}
/// The initial state of SplashState
/// {@endtemplate}
class SplashInitial extends SplashState {
  /// {@macro splash_initial}
  const SplashInitial() : super();
}

/// {@template splash_completed}
/// State when splash screen has completed
/// {@endtemplate}
class SplashCompleted extends SplashState {
  /// {@macro splash_completed}
  const SplashCompleted() : super();
}
