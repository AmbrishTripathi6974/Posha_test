import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/adopt/adopt_bloc.dart';
import '../../blocs/adopt/adopt_state.dart';
import '../../core/constants.dart'; // for colors like `black`
import '../../models/pet_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionBloc, AdoptionState>(
      builder: (context, state) {
        if (state is AdoptionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdoptionLoaded) {
          final adoptedPets = state.adoptedCats;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  "Adopted Pets",
                  style: TextStyle(
                    color: black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              adoptedPets.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "No adopted pets yet.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final cat = adoptedPets[index];
                            return _AdoptedPetTile(cat: cat);
                          },
                          childCount: adoptedPets.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                      ),
                    ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _AdoptedPetTile extends StatelessWidget {
  final Cat cat;
  const _AdoptedPetTile({required this.cat});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cat.color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(cat.image),
            backgroundColor: cat.color,
          ),
          const SizedBox(height: 10),
          Text(
            cat.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: black,
            ),
          ),
          Text(
            cat.location,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Adopted",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
