import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class MapState extends Equatable {
  final bool loading;
  final String? errorMessage;

  final LatLng? currentLocation;
  final List<GeoPlaceModel> suggestions;
  final GeoPlaceModel? selectedPlace;
  final List<LatLng> routePoints;

  const MapState({
    this.loading = false,
    this.errorMessage,
    this.currentLocation,
    this.suggestions = const [],
    this.selectedPlace,
    this.routePoints = const [],
  });

  MapState copyWith({
    bool? loading,
    String? errorMessage,
    LatLng? currentLocation,
    List<GeoPlaceModel>? suggestions,
    GeoPlaceModel? selectedPlace,
    List<LatLng>? routePoints,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
      currentLocation: currentLocation ?? this.currentLocation,
      suggestions: suggestions ?? this.suggestions,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      routePoints: routePoints ?? this.routePoints,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    errorMessage,
    currentLocation,
    suggestions,
    selectedPlace,
    routePoints,
  ];
}
