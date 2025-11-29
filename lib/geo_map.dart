import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps/Features/Favorites/faourite_view.dart';
import 'package:maps/Features/Favorites/fav_service.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';
import 'package:maps/utils/geo_location_service.dart';
import 'package:maps/utils/helper.dart';
import 'package:maps/utils/location_service.dart';
import 'package:maps/utils/route_service.dart';
import 'package:maps/utils/route_test_service.dart';
import 'package:maps/utils/theme_service.dart';
import 'package:maps/utils/app_theme.dart';
import 'package:maps/widgets/custom_list_view.dart';
import 'package:maps/widgets/custom_model_bottom_sheet.dart';
import 'package:maps/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class GeoMap extends StatefulWidget {
  const GeoMap({super.key});

  @override
  State<GeoMap> createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  final MapController mapController = MapController();
  final LatLng center = const LatLng(30.0444, 31.2357);
  final double initialZoom = 13.0;

  late LocationService locationService;
  late GeoLocationService geoLocationService;
  late TextEditingController searchTextController;

  final RouteService routeService = RouteService();
  final RoutingService routingService = RoutingService();

  List<GeoPlaceModel> places = [];
  List<Polyline> polylines = [];
  List<Marker> markers = [];
  bool showSearchList = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    searchTextController = TextEditingController();
    geoLocationService = GeoLocationService();
    updateMyLocation();
    fetchPreditions();

    markers = [
      Marker(
        point: const LatLng(30.96197054807345, 31.242976178045918),
        child: Icon(Icons.location_on, color: Colors.red[700], size: 40),
      ),
    ];
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchTextController.dispose();
    super.dispose();
  }

  void fetchPreditions() {
    searchTextController.addListener(() {
      final text = searchTextController.text;
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 400), () async {
        if (!mounted) return;
        if (text.isNotEmpty) {
          try {
            final items = await geoLocationService.autoComplete(text: text);
            if (!mounted) return;
            setState(() {
              places = items;
              showSearchList = true;
            });
          } catch (e) {
            debugPrint('Autocomplete error: $e');
          }
        } else {
          setState(() {
            places.clear();
            showSearchList = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final isDark =
        themeService.themeMode == ThemeMode.dark ||
        (themeService.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Maps'),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              tooltip: isDark ? 'Light Mode' : 'Dark Mode',
              onPressed: () => themeService.toggleTheme(),
            ),
            PopupMenuButton<ThemeMode>(
              icon: const Icon(Icons.more_vert),
              onSelected: (mode) => themeService.setThemeMode(mode),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: ThemeMode.light,
                      child: Row(
                        children: [
                          Icon(
                            Icons.light_mode,
                            color:
                                themeService.isLightMode
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Light',
                            style: TextStyle(
                              fontWeight:
                                  themeService.isLightMode
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: ThemeMode.dark,
                      child: Row(
                        children: [
                          Icon(
                            Icons.dark_mode,
                            color:
                                themeService.isDarkMode
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Dark',
                            style: TextStyle(
                              fontWeight:
                                  themeService.isDarkMode
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: ThemeMode.system,
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_suggest,
                            color:
                                themeService.isSystemMode
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'System',
                            style: TextStyle(
                              fontWeight:
                                  themeService.isSystemMode
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "open_favorites",
              onPressed: _openFavorites,
              child: const Icon(Icons.favorite),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: "update_location",
              onPressed: updateMyLocation,
              child: const Icon(Icons.my_location),
            ),
          ],
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: initialZoom,
                interactionOptions: const InteractionOptions(
                  flags:
                      InteractiveFlag.drag |
                      InteractiveFlag.pinchZoom |
                      InteractiveFlag.doubleTapZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      isDark
                          ? AppTheme.getDarkMapTileUrl()
                          : AppTheme.getLightMapTileUrl(),
                  userAgentPackageName: 'com.example.maps',
                ),
                if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                MarkerLayer(markers: markers),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 8,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(controller: searchTextController),
                  const SizedBox(height: 8),
                  CustomListView(places: places, onTap: _handlePlaceSelection),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                FavoritesView(onOpen: (place) => _showFavoriteOnMap(place)),
      ),
    );
  }

  Future<void> _showFavoriteOnMap(GeoPlaceModel place) async {
    if (place.lat == null || place.lon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This favorite location has no coordinates'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final location = LatLng(place.lat!, place.lon!);
    mapController.move(location, 15.0);

    setState(() {
      markers = [
        Marker(
          point: location,
          child: GestureDetector(
            onTap: () => _showFavoriteDetails(place),
            child: Icon(Icons.location_on, color: Colors.red[700], size: 40),
          ),
        ),
      ];
      polylines.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing ${place.formatted ?? place.city ?? 'location'}'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Directions',
          onPressed: () => _getDirectionsToFavorite(place),
        ),
      ),
    );
  }

  Future<void> _showFavoriteDetails(GeoPlaceModel place) async {
    if (place.placeId != null) {
      UIHelper.showLoadingDialog(context);
      try {
        final feature = await geoLocationService.getPlaceDetails(
          placeId: place.placeId!,
        );
        if (!mounted) return;
        UIHelper.closeDialog(context);

        await _showBottomSheet(
          feature: feature,
          lat: place.lat!,
          lon: place.lon!,
        );
      } catch (e) {
        if (mounted) {
          UIHelper.closeDialog(context);
          _showSimpleFavoriteSheet(place);
        }
      }
    } else {
      _showSimpleFavoriteSheet(place);
    }
  }

  void _showSimpleFavoriteSheet(GeoPlaceModel place) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.formatted ?? place.city ?? 'Unknown',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                if (place.country != null) Text('Country: ${place.country}'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _getDirectionsToFavorite(place);
                      },
                      icon: const Icon(Icons.navigation),
                      label: const Text('Directions'),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _getDirectionsToFavorite(GeoPlaceModel place) async {
    if (place.lat == null || place.lon == null) return;

    UIHelper.showLoadingDialog(context);

    try {
      final hasService = await locationService.checkAndRequestLocationService();
      final hasPermission =
          await locationService.checkAndRequestLocationPermission();

      if (!hasService || !hasPermission) {
        if (mounted) {
          UIHelper.closeDialog(context);
          UIHelper.showErrorSnackBar(
            context,
            'Location access is required for directions',
          );
        }
        return;
      }

      final currentLocation = await locationService.getCurrentLocation();

      if (currentLocation?.latitude == null ||
          currentLocation?.longitude == null) {
        if (mounted) {
          UIHelper.closeDialog(context);
          UIHelper.showErrorSnackBar(
            context,
            'Could not determine your current location',
          );
        }
        return;
      }

      final origin = LatLng(
        currentLocation!.latitude!,
        currentLocation.longitude!,
      );
      final destination = LatLng(place.lat!, place.lon!);

      final routePoints = await routingService.getRoute(
        origin: origin,
        destination: destination,
      );

      if (!mounted) return;
      UIHelper.closeDialog(context);

      if (routePoints.isEmpty) {
        UIHelper.showErrorSnackBar(context, 'No route found to this location');
        return;
      }

      setState(() {
        polylines = [
          Polyline(points: routePoints, color: Colors.blue, strokeWidth: 5.0),
        ];
      });

      final bounds = LatLngBounds.fromPoints(routePoints);
      mapController.fitCamera(
        CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50)),
      );
    } catch (e) {
      if (mounted) {
        UIHelper.closeDialog(context);
        UIHelper.showErrorSnackBar(
          context,
          'Failed to calculate route: ${e.toString()}',
        );
      }
    }
  }

  Future<void> _handlePlaceSelection(GeoPlaceModel place) async {
    setState(() {
      places.clear();
      searchTextController.clear();
    });

    UIHelper.showLoadingDialog(context);
    try {
      final feature = await geoLocationService.getPlaceDetails(
        placeId: place.placeId!,
      );
      if (!mounted) return;
      UIHelper.closeDialog(context);

      final lat = feature.lat;
      final lon = feature.lon;

      if (lat == null || lon == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selected place has no coordinates')),
        );
        return;
      }

      mapController.move(LatLng(lat, lon), 14.0);

      setState(() {
        markers = [
          Marker(
            point: LatLng(lat, lon),
            child: Icon(Icons.location_on, color: Colors.red[700], size: 40),
          ),
        ];
      });

      await _showBottomSheet(feature: feature, lat: lat, lon: lon);
    } catch (e) {
      if (mounted) {
        UIHelper.closeDialog(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Place details error: $e')));
      }
    }
  }

  Future<void> _showBottomSheet({
    required feature,
    required double lat,
    required double lon,
  }) async {
    final favoritesService = context.read<FavoritesService>();

    await CustomModelBottomSheet.show(
      context,
      feature: feature,
      lat: lat,
      lon: lon,
      locationService: locationService,
      routeService: routeService,
      mapController: mapController,
      onShowRoute: (routePoints) {
        setState(() {
          polylines = [
            Polyline(points: routePoints, color: Colors.blue, strokeWidth: 5.0),
          ];
        });

        final bounds = LatLngBounds.fromPoints(routePoints);
        mapController.fitCamera(
          CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50)),
        );
      },
      routeTestService: routingService,
      favoritesService: favoritesService,
    );
  }

  void updateMyLocation() async {
    final okService = await locationService.checkAndRequestLocationService();
    final okPerm = await locationService.checkAndRequestLocationPermission();
    if (!okService || !okPerm) return;

    final loc = await locationService.getCurrentLocation();
    if (loc != null && loc.latitude != null && loc.longitude != null) {
      mapController.move(LatLng(loc.latitude!, loc.longitude!), 15.0);
    }
  }
}
