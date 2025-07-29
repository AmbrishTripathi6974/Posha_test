import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/pet_model.dart';
import '../../../repo/pet_repository.dart';
import 'fav_event.dart';
import 'fav_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final PetRepository repository;

  FavoriteBloc(this.repository) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<FavoriteState> emit) async {
    final favoriteNames = await repository.localStorage.getAllFavoriteNames();

    final favoritePets = cats.where((cat) => favoriteNames.contains(cat.name)).map(
      (cat) => cat.copyWith(isFavorite: true),
    ).toList();

    emit(FavoriteLoaded(favoritePets));
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<FavoriteState> emit) async {
    final isFav = !event.pet.isFavorite;
    await repository.localStorage.saveFavorite(event.pet.name, isFav);
    add(LoadFavorites());
  }
}
