import '../../../models/pet_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Cat> favorites;
  FavoriteLoaded(this.favorites);
}
