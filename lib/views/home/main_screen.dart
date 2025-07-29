import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posha/views/favorites/favorites_screen.dart';
import 'package:posha/views/history/history_screen.dart';
import 'package:posha/views/home/home_screen.dart';
import 'package:posha/widgets/bottom_nav/bottom_nav_cubit.dart';

import '../../widgets/bottom_nav/custom_bottom_nav.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoriteScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NavCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: IndexedStack(
            index: selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: const CustomBottomNav(),
        );
      },
    );
  }
}
