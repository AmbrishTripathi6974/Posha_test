import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  /// Save availability status to SharedPreferences
  Future<void> saveStatus(String name, bool isAvailable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(name, isAvailable);
  }

  /// Retrieve availability status from SharedPreferences
  Future<bool?> getStatus(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(name);
  }

  Future<void> saveFavorite(String name, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fav_$name', isFavorite);
  }

  Future<bool?> getFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('fav_$name');
  }

  Future<List<String>> getAllFavoriteNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .where((k) => k.startsWith('fav_') && prefs.getBool(k) == true)
        .map((k) => k.replaceFirst('fav_', ''))
        .toList();
  }

  Future<void> saveAdoption(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adopted_$name', true);
  }

  Future<List<String>> getAllAdoptedNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .where((k) => k.startsWith('adopted_') && prefs.getBool(k) == true)
        .map((k) => k.replaceFirst('adopted_', ''))
        .toList();
  }
}
