import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posha/utils/helpers.dart';

import '../../../blocs/adopt/adopt_bloc.dart';
import '../../../blocs/adopt/adopt_state.dart';
import '../../../models/pet_model.dart';
import '../../details/details_screen.dart';
import '../../favorites/bloc/fav_bloc.dart';
import '../../favorites/bloc/fav_event.dart';
import '../../favorites/bloc/fav_state.dart';

class PetTile extends StatelessWidget {
  final Cat cat;
  const PetTile({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final size = THelperFunctions.screenSize(context);
    final theme = Theme.of(context);

    return BlocBuilder<AdoptionBloc, AdoptionState>(
      builder: (context, adoptState) {
        return BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, favState) {
            Cat updatedCat = cat;

            // Update favorite status
            if (favState is FavoriteLoaded) {
              final match = favState.favorites.firstWhere(
                (fav) => fav.name == cat.name,
                orElse: () => cat.copyWith(isFavorite: false),
              );
              updatedCat = updatedCat.copyWith(isFavorite: match.isFavorite);
            }

            // Update adoption status
            if (adoptState is AdoptionLoaded) {
              final isAdopted =
                  adoptState.adoptedCats.any((c) => c.name == cat.name);
              updatedCat = updatedCat.copyWith(isAvailable: !isAdopted);
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PetsDetailPage(cat: updatedCat),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: size.height * 0.3,
                  width: size.width * 0.55,
                  color: updatedCat.color.withOpacity(0.5),
                  child: Stack(
                    children: [
                      // Background paws
                      Positioned(
                        bottom: -10,
                        right: -10,
                        height: 100,
                        width: 100,
                        child: Transform.rotate(
                          angle: 12,
                          child: SvgPicture.asset(
                            'assets/svg/cat_paw.svg',
                            color: cat.color,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: -25,
                        height: 90,
                        width: 90,
                        child: Transform.rotate(
                          angle: -11.5,
                          child: SvgPicture.asset(
                            'assets/svg/cat_paw.svg',
                            color: cat.color,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Cat image with working Hero animation
                      Positioned(
                        bottom: -10,
                        right: 10,
                        child: Hero(
                          tag:
                              '${cat.name}_${cat.image}_${cat.hashCode}', // ✅ Unique per widget
                          child: Image.asset(
                            cat.image,
                            height: size.height * 0.22,
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    updatedCat.name,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<FavoriteBloc>().add(
                                          ToggleFavorite(updatedCat),
                                        );
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      updatedCat.isFavorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline_rounded,
                                      color: updatedCat.isFavorite
                                          ? Colors.red
                                          : Colors.black.withOpacity(0.6),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Availability status
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: updatedCat.isAvailable
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      color: updatedCat.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    updatedCat.isAvailable
                                        ? 'Available'
                                        : 'Adopted',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: updatedCat.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
