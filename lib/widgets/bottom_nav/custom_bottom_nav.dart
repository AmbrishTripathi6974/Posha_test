import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants.dart';
import 'bottom_nav_cubit.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home_outlined,
      Icons.favorite_outline_rounded,
      Icons.history_rounded,
    ];

    return BlocBuilder<NavCubit, int>(
      builder: (context, selectedIndex) {
        return Container(
          height: 60,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: () {
                  context.read<NavCubit>().setTab(index);
                },
                child: Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 28,
                        color: selectedIndex == index
                            ? blue
                            : black.withOpacity(0.6),
                      ),
                      const SizedBox(height: 6),
                      if (selectedIndex == index)
                        Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: blue,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
