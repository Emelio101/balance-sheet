part of 'home_cubit.dart';

enum HomeTab { dashboard, transactions, analytics, settings }

class HomeState extends Equatable {
  const HomeState({
    this.selectedTab = HomeTab.dashboard,
  });

  final HomeTab selectedTab;

  @override
  List<Object> get props => [selectedTab];

  HomeState copyWith({
    HomeTab? selectedTab,
  }) {
    return HomeState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
