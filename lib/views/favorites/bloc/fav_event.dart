import '../../../models/pet_model.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final Cat pet;
  ToggleFavorite(this.pet);
}

class RefreshFavorites extends FavoriteEvent {}
