import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../models/pet_model.dart';
import '../../../blocs/category_cubit.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CategoryCubit, int>(
      builder: (context, selectedCategory) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12.withOpacity(0.03),
                ),
                child: const Icon(Icons.tune_rounded),
              ),
              ...List.generate(
                categories.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.read<CategoryCubit>().selectCategory(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedCategory == index
                            ? buttonColor
                            : Colors.black12.withOpacity(0.03),
                      ),
                      child: Text(
                        categories[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: selectedCategory == index
                              ? Colors.white
                              : black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
