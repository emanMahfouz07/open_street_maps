// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:maps/utils/geo_location_service.dart';
// import 'package:maps/utils/location_service.dart';

// import 'map_state.dart';

// class MapCubit extends Cubit<MapState> {
//   final LocationService locationService;
//   final GeoLocationService geoLocationService;
//   //final RouteService routeService;

//   MapCubit({
//     required this.locationService,
//     required this.geoLocationService,
//     // required this.routeService,
//   }) : super(const MapState()) {
//     // Optionally initialize current location on creation:
//     _init();
//   }

//   Timer? _debounce;

//   Future<void> _init() async {
//     emit(state.copyWith(loading: true, errorMessage: null));
//     try {
//       final hasPermission =
//           await locationService.checkAndRequestLocationPermission();
//       if (!hasPermission) {
//         emit(
//           state.copyWith(
//             loading: false,
//             errorMessage: 'Location permission denied',
//           ),
//         );
//         return;
//       }
//       final loc = await locationService.getCurrentLocationOnce();
//       if (loc != null) {
//         final latlng = LatLng(loc.latitude!, loc.longitude!);
//         emit(state.copyWith(loading: false, currentLocation: latlng));
//       } else {
//         emit(state.copyWith(loading: false));
//       }
//     } catch (e) {
//       emit(state.copyWith(loading: false, errorMessage: e.toString()));
//     }
//   }

//   /// Debounced search for autocomplete suggestions
//   void searchPlaces(String query) {
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 350), () async {
//       if (query.trim().isEmpty) {
//         emit(state.copyWith(suggestions: []));
//         return;
//       }
//       emit(state.copyWith(loading: true, errorMessage: null));
//       try {
//         final items = await geoLocationService.autoComplete(text: query);
//         // items assumed List<GeoPlaceModel> — adjust if your service returns different shape
//         emit(state.copyWith(loading: false, suggestions: items));
//       } catch (e) {
//         emit(state.copyWith(loading: false, errorMessage: e.toString()));
//       }
//     });
//   }

//   /// call when user taps a suggestion; optionally fetch detailed place info inside service
//   Future<void> selectPlace(GeoPlaceModel place) async {
//     try {
//       emit(state.copyWith(loading: true, errorMessage: null));
//       // If your GeoPlaceModel is a container (features list), you might want to pick the first result.
//       // Here we just set selectedPlace to the passed model.
//       // If you need to fetch details by placeId, call geoLocationService.getPlaceDetails(...)
//       emit(
//         state.copyWith(loading: false, selectedPlace: place, suggestions: []),
//       );
//     } catch (e) {
//       emit(state.copyWith(loading: false, errorMessage: e.toString()));
//     }
//   }

//   /// Request route from origin (currentLocation) to destination (from selectedPlace)
//   Future<void> fetchRouteAndShow({
//     LatLng? origin,
//     required LatLng destination,
//   }) async {
//     emit(state.copyWith(loading: true, errorMessage: null));
//     try {
//       final from = origin ?? state.currentLocation;
//       if (from == null) {
//         emit(
//           state.copyWith(loading: false, errorMessage: 'Origin not available'),
//         );
//         return;
//       }

//       // Build request models expected by your RouteService
//       // Here we assume routeService.fetchRoutesData(origin, destination) returns List<LatLng>
//       final routePoints = await routeService.fetchRoutesData(
//         origin: from,
//         destination: destination,
//       );

//       emit(state.copyWith(loading: false, routePoints: routePoints));
//     } catch (e) {
//       emit(state.copyWith(loading: false, errorMessage: e.toString()));
//     }
//   }

//   /// Clear suggestions
//   void clearSuggestions() {
//     emit(state.copyWith(suggestions: []));
//   }

//   @override
//   Future<void> close() {
//     _debounce?.cancel();
//     return super.close();
//   }
// }
