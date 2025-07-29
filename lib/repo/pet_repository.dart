import '../models/pet_model.dart';
import '../core/services/local_storage.dart';

class PetRepository {
  final LocalStorageService localStorage;

  PetRepository(this.localStorage);

  Future<List<Cat>> getPets({int page = 1, int limit = 10}) async {
    await Future.delayed(
        const Duration(milliseconds: 800)); 
    final start = (page - 1) * limit;
    final end = (start + limit).clamp(0, cats.length);

    // Read and update each pet's availability status
    final updatedPets = await Future.wait(
      cats.sublist(start, end).map((cat) async {
        final isAvailable = await localStorage.getStatus(cat.name);
        final isFavorite = await localStorage.getFavorite(cat.name);
        return cat.copyWith(
          isAvailable: isAvailable ?? cat.isAvailable,
          isFavorite: isFavorite ?? false,
        );
      }),
    );

    return updatedPets;
  }

  Future<void> toggleAvailability(String name) async {
    final status = await localStorage.getStatus(name);
    await localStorage.saveStatus(name, !(status ?? true));
  }
}
