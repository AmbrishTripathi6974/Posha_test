import '../../models/pet_model.dart';

abstract class AdoptionEvent {}

class AdoptPet extends AdoptionEvent {
  final Cat pet;
  AdoptPet(this.pet);
}

class LoadAdoptedPets extends AdoptionEvent {}
