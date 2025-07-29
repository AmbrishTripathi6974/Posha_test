import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:posha/utils/helpers.dart';
import 'package:readmore/readmore.dart';

import '../../blocs/adopt/adopt_bloc.dart';
import '../../blocs/adopt/adopt_event.dart';
import '../../blocs/adopt/adopt_state.dart';
import '../../core/constants.dart';
import '../../models/pet_model.dart';
import '../favorites/bloc/fav_bloc.dart';
import '../favorites/bloc/fav_event.dart';
import '../favorites/bloc/fav_state.dart';

class PetsDetailPage extends StatelessWidget {
  final Cat cat;
  const PetsDetailPage({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final size = THelperFunctions.screenSize(context);

    return Scaffold(
      backgroundColor: cat.color.withOpacity(0.8),
      body: BlocBuilder<AdoptionBloc, AdoptionState>(
        builder: (context, adoptState) {
          return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favState) {
              Cat updatedCat = cat;

              if (favState is FavoriteLoaded) {
                updatedCat = favState.favorites.firstWhere(
                  (fav) => fav.name == cat.name,
                  orElse: () => cat.copyWith(isFavorite: false),
                );
              }

              if (adoptState is AdoptionLoaded) {
                final isAdopted =
                    adoptState.adoptedCats.any((c) => c.name == cat.name);
                updatedCat = updatedCat.copyWith(isAvailable: !isAdopted);
              }

              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  _backgroundPattern(size, cat),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconButton(() => Navigator.pop(context),
                            Icons.arrow_back_ios_new_rounded),
                        _iconButton(() {}, Icons.more_horiz),
                      ],
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.12,
                    child: Hero(
                      tag:
                          '${cat.name}_${cat.image}_${cat.hashCode}', 
                      child: Image.asset(
                        cat.image,
                        height: size.height * 0.3,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.62,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              _nameLocationFavorite(context, updatedCat),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _infoBox(color1, color1.withOpacity(0.5),
                                      updatedCat.sex, "Sex"),
                                  _infoBox(color2, color2.withOpacity(0.5),
                                      "${updatedCat.age} Years", "Age"),
                                  _infoBox(color3, color3.withOpacity(0.5),
                                      "${updatedCat.weight} KG", "Weight"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _ownerInfo(updatedCat),
                              const SizedBox(height: 20),
                              ReadMoreText(
                                updatedCat.description,
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black54),
                                moreStyle: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600),
                                lessStyle: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: updatedCat.isAvailable
                                    ? () {
                                        context
                                            .read<AdoptionBloc>()
                                            .add(AdoptPet(updatedCat));
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Lottie.asset(
                                                    'assets/svg/confetti.json',
                                                    repeat: false),
                                                const SizedBox(height: 16),
                                                Text(
                                                  "You’ve now adopted ${updatedCat.name}!",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).then((_) =>
                                            Navigator.pop(context, 'refresh'));
                                      }
                                    : null,
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: updatedCat.isAvailable
                                        ? buttonColor
                                        : Colors.red.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      updatedCat.isAvailable
                                          ? 'Adopt Me'
                                          : 'Already Adopted',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _backgroundPattern(Size size, Cat cat) {
    return Stack(
      children: [
        Positioned(
          left: -60,
          top: 30,
          child: Transform.rotate(
            angle: -11.5,
            child: SvgPicture.asset(
              "assets/svg/cat_paw.svg",
              color: cat.color,
              height: 200,
            ),
          ),
        ),
        Positioned(
          right: -60,
          bottom: size.height * 0.5,
          child: Transform.rotate(
            angle: 12,
            child: SvgPicture.asset(
              "assets/svg/cat_paw.svg",
              color: cat.color,
              height: 200,
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconButton(VoidCallback onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: black),
      ),
    );
  }

  Widget _nameLocationFavorite(BuildContext context, Cat cat) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cat.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: blue),
                  const SizedBox(width: 4),
                  Text(
                    '${cat.location} (${cat.distance} Km)',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.read<FavoriteBloc>().add(ToggleFavorite(cat)),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  color: cat.isFavorite
                      ? Colors.red.withOpacity(0.1)
                      : black.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              cat.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: cat.isFavorite ? Colors.red : black.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoBox(Color mainColor, Color bgColor, String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: 0,
            child: Transform.rotate(
              angle: 12,
              child: SvgPicture.asset(
                'assets/svg/cat_paw.svg',
                color: mainColor,
                height: 55,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ownerInfo(Cat cat) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(cat.owner.image),
          backgroundColor: cat.color,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cat.owner.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: black),
              ),
              Text(
                "${cat.name} Owner",
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        _contactIcon(
            Icons.chat_outlined, Colors.lightBlue, color3.withOpacity(0.3)),
        const SizedBox(width: 10),
        _contactIcon(
            Icons.phone_outlined, Colors.red, Colors.red.withOpacity(0.2)),
      ],
    );
  }

  Widget _contactIcon(IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 16),
    );
  }
}
