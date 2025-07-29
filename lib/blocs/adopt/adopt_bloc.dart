import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/pet_model.dart';
import '../../core/services/local_storage.dart';
import 'adopt_event.dart';
import 'adopt_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final LocalStorageService storageService;

  AdoptionBloc(this.storageService) : super(AdoptionInitial()) {
    on<LoadAdoptedPets>(_onLoad);
    on<AdoptPet>(_onAdopt);
  }

  Future<void> _onLoad(
      LoadAdoptedPets event, Emitter<AdoptionState> emit) async {
    emit(AdoptionLoading());
    final adoptedNames = await storageService.getAllAdoptedNames();
    final adoptedPets =
        cats.where((c) => adoptedNames.contains(c.name)).toList();
    emit(AdoptionLoaded(adoptedPets));
  }

  Future<void> _onAdopt(
      AdoptPet event, Emitter<AdoptionState> emit) async {
    await storageService.saveStatus(event.pet.name, false);
    await storageService.saveAdoption(event.pet.name);
    add(LoadAdoptedPets());
  }
}
