import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pet_model.dart';
import '../repo/pet_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository repository;

  int _currentPage = 1;
  final int _limit = 10;
  bool _hasReachedEnd = false;

  final List<Cat> _allPets = [];

  PetBloc(this.repository) : super(PetInitial()) {
    on<FetchPets>(_onFetchPets);
    on<TogglePetStatus>(_onTogglePetStatus);
    on<SearchPets>(_onSearchPets);
  }

  void _onFetchPets(FetchPets event, Emitter<PetState> emit) async {
    if (_hasReachedEnd) return;

    try {
      if (state is PetInitial || state is PetLoading) {
        emit(PetLoading());
      }

      final newPets = await repository.getPets(page: _currentPage, limit: _limit);
      final isEnd = newPets.length < _limit;
      _currentPage++;

      for (final pet in newPets) {
        if (!_allPets.any((p) => p.name == pet.name)) {
          _allPets.add(pet);
        }
      }

      final updatedPets = [..._allPets];

      emit(PetLoaded(pets: updatedPets, hasReachedEnd: isEnd));
      _hasReachedEnd = isEnd;
    } catch (e) {
      emit(PetError('Failed to fetch pets.'));
    }
  }

  void _onTogglePetStatus(TogglePetStatus event, Emitter<PetState> emit) async {
    await repository.toggleAvailability(event.petName);

    final newStatus = await repository.localStorage.getStatus(event.petName);

    if (state is PetLoaded) {
      final currentPets = (state as PetLoaded).pets;

      final updatedPets = currentPets.map((p) {
        return p.name == event.petName
            ? p.copyWith(isAvailable: newStatus ?? true)
            : p;
      }).toList();

      emit(PetLoaded(pets: updatedPets, hasReachedEnd: _hasReachedEnd));
    }
  }

  void _onSearchPets(SearchPets event, Emitter<PetState> emit) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      final uniquePets = {
        for (var pet in _allPets) pet.name: pet,
      }.values.toList();

      emit(PetLoaded(pets: uniquePets, hasReachedEnd: _hasReachedEnd));
    } else {
      final filtered = _allPets
          .where((cat) => cat.name.toLowerCase().contains(query))
          .toList();

      emit(PetLoaded(pets: filtered, hasReachedEnd: true));
    }
  }
}
