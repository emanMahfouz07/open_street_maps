import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class FavoritesService extends ChangeNotifier {
  static const String _storageKey = 'favorite_places_v1';

  final SharedPreferences _sharedPrefs;
  final List<GeoPlaceModel> _favoritePlaces = [];

  FavoritesService._(this._sharedPrefs) {
    _loadFromStorage();
  }

  static Future<FavoritesService> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return FavoritesService._(prefs);
  }

  List<GeoPlaceModel> get favoritePlaces => List.unmodifiable(_favoritePlaces);

  int get count => _favoritePlaces.length;

  bool containsPlace(String? placeId) {
    if (placeId == null) return false;
    return _favoritePlaces.any((p) => p.placeId == placeId);
  }

  GeoPlaceModel? getPlaceById(String? placeId) {
    if (placeId == null) return null;
    try {
      return _favoritePlaces.firstWhere((p) => p.placeId == placeId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadFromStorage() async {
    try {
      final savedList = _sharedPrefs.getStringList(_storageKey) ?? [];
      _favoritePlaces
        ..clear()
        ..addAll(
          savedList.map((jsonStr) {
            try {
              final map = jsonDecode(jsonStr) as Map<String, dynamic>;
              return GeoPlaceModel.fromJson(map);
            } catch (e) {
              debugPrint('Error parsing favorite place: $e');
              return null;
            }
          }).whereType<GeoPlaceModel>(),
        );
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<bool> _saveToStorage() async {
    try {
      final asJsonStrings =
          _favoritePlaces.map((p) => jsonEncode(p.toJson())).toList();
      return await _sharedPrefs.setStringList(_storageKey, asJsonStrings);
    } catch (e) {
      debugPrint('Error saving favorites: $e');
      return false;
    }
  }

  Future<bool> addPlace(GeoPlaceModel place) async {
    final id = place.placeId;
    if (id == null || id.isEmpty) {
      debugPrint('Cannot add place without valid placeId');
      return false;
    }

    if (containsPlace(id)) {
      debugPrint('Place already in favorites');
      return false;
    }

    _favoritePlaces.add(place);
    notifyListeners();

    return await _saveToStorage();
  }

  Future<bool> removePlaceById(String? placeId) async {
    if (placeId == null) return false;

    final initialLength = _favoritePlaces.length;
    _favoritePlaces.removeWhere((p) => p.placeId == placeId);

    // Check if anything was actually removed
    if (_favoritePlaces.length == initialLength) return false;

    notifyListeners();
    return await _saveToStorage();
  }

  Future<bool> togglePlace(GeoPlaceModel place) async {
    final id = place.placeId;
    if (id == null || id.isEmpty) return false;

    if (containsPlace(id)) {
      await removePlaceById(id);
    } else {
      await addPlace(place);
    }

    return true;
  }

  Future<bool> clearAll() async {
    if (_favoritePlaces.isEmpty) return true;

    _favoritePlaces.clear();
    notifyListeners();

    return await _saveToStorage();
  }

  Future<void> reload() async {
    await _loadFromStorage();
  }
}
