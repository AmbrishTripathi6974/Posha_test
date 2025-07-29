import '../../../models/pet_model.dart';

abstract class PetState {}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<Cat> pets;
  final bool hasReachedEnd;

  PetLoaded({required this.pets, this.hasReachedEnd = false});
}

class PetError extends PetState {
  final String message;
  PetError(this.message);
}
