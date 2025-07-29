import '../../../models/pet_model.dart';

abstract class AdoptionState {}

class AdoptionInitial extends AdoptionState {}

class AdoptionLoading extends AdoptionState {}

class AdoptionLoaded extends AdoptionState {
  final List<Cat> adoptedCats; // ✅ Correct field name

  AdoptionLoaded(this.adoptedCats);
}

class AdoptionUpdated extends AdoptionState {
  final String catName;
  AdoptionUpdated(this.catName);
}
