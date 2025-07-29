abstract class PetEvent {}

class FetchPets extends PetEvent {}

class TogglePetStatus extends PetEvent {
  final String petName;
  TogglePetStatus(this.petName);
}

class SearchPets extends PetEvent {
  final String query;
  SearchPets(this.query);
}
