import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/pet_bloc.dart';
import '../../../blocs/pet_event.dart';
import '../../../blocs/pet_state.dart';
import 'pet_tile.dart';

class PetGrid extends StatefulWidget {
  const PetGrid({super.key});

  @override
  State<PetGrid> createState() => _PetGridState();
}

class _PetGridState extends State<PetGrid> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    context.read<PetBloc>().add(FetchPets());
  }

  void _scrollListener() {
    if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      context.read<PetBloc>().add(FetchPets());
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetBloc, PetState>(
      builder: (context, state) {
        if (state is PetLoading || state is PetInitial) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PetLoaded) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pet = state.pets[index];
                  return PetTile(cat: pet);
                },
                childCount: state.pets.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
            ),
          );
        } else if (state is PetError) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('Failed to load pets')),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: Text('Unknown state')),
          );
        }
      },
    );
  }
}
