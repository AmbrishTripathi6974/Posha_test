import 'package:flutter/material.dart';
import 'package:posha/views/home/widgets/categories.dart';
import 'package:posha/views/home/widgets/category_item.dart';
import 'package:posha/views/home/widgets/custom_header.dart';
import 'package:posha/views/home/widgets/pet_banner.dart';
import 'package:posha/views/home/widgets/pet_grid.dart';

import '../search/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Header
            SliverToBoxAdapter(
              child: Column(
                children: const [
                  CustomHeader(),
                  SizedBox(height: 20),
                  CustomSearchBar(),
                  SizedBox(height: 20),
                  PetBanner(),
                  SizedBox(height: 20),
                  Categories(name: "Categories"),
                  SizedBox(height: 15),
                  CategoryItem(),
                  SizedBox(height: 25),
                  Categories(name: "Adopt Pet"),
                  SizedBox(height: 15),
                ],
              ),
            ),

            /// Pet Grid
            const PetGrid(),

            /// Bottom Spacing after grid
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
