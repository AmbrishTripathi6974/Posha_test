import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/pet_model.dart';
import '../../../blocs/category_cubit.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  color: colorScheme.surfaceVariant.withOpacity(0.1),
                ),
                child: Icon(Icons.tune_rounded, color: colorScheme.onSurface),
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
                            ? colorScheme.primary
                            : colorScheme.surfaceVariant.withOpacity(0.1),
                      ),
                      child: Text(
                        categories[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: selectedCategory == index
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
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
