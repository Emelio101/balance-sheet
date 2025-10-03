import 'package:balance_sheet/dashboard/dashboard.dart';
import 'package:balance_sheet/home/cubit/home_cubit.dart';
import 'package:balance_sheet/settings/settings.dart';
import 'package:balance_sheet/transactions/transactions.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildCurrentPage(state.selectedTab),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedTab.index,
            onTap: (index) {
              context.read<HomeCubit>().changeTab(HomeTab.values[index]);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentPage(HomeTab tab) {
    switch (tab) {
      case HomeTab.dashboard:
        return const DashboardPage();
      case HomeTab.transactions:
        return const TransactionsPage();
      case HomeTab.analytics:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Analytics'),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Analytics Coming Soon',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Detailed insights and reports will be available here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      case HomeTab.settings:
        return const SettingsPage();
    }
  }
}
