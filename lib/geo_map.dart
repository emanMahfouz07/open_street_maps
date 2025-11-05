import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';
import 'package:maps/utils/geo_location_service.dart';
import 'package:maps/utils/location_service.dart';

class GeoMap extends StatefulWidget {
  const GeoMap({super.key});

  @override
  State<GeoMap> createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  final MapController mapController = MapController();
  final LatLng center = const LatLng(30.0444, 31.2357);
  final double initialZoom = 13.0;
  Location location = Location();

  late LocationService locationService;
  late GeoLocationService geoLocationService;
  late TextEditingController searchTextController;
  List<GeoPlaceModel> places = [];
  @override
  void initState() {
    locationService = LocationService();
    searchTextController = TextEditingController();
    geoLocationService = GeoLocationService();
    updateMyLocation();
    fetchPreditions();

    super.initState();
  }

  void fetchPreditions() {
    searchTextController.addListener(() async {
      print('🔍 User typing: ${searchTextController.text}');
      if (searchTextController.text.isNotEmpty) {
        var items = await geoLocationService.autoComplete(
          text: searchTextController.text,
        );
        print('✅ API returned ${items.length} results');
        setState(() {
          places = items;
        });
      } else {
        print('❌ Empty search, clearing list');
        setState(() {
          places.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ الخريطة هنا لوحدها
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
                    'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=29e466b51aed4732a5cef3f4aeec458a',
                userAgentPackageName: 'com.example.maps',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(30.96197054807345, 31.242976178045918),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red[700],
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            left: 16,
            right: 16,
            top: 40,
            child: CustomTextField(controller: searchTextController),
          ),

          Positioned(
            left: 16,
            right: 16,
            top: 100,
            child: SizedBox(
              height: 300,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(title: Text(places[index].formatted ?? ''));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: places.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();

    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        mapController.move(
          LatLng(locationData.latitude!, locationData.longitude!),
          15.0,
        );
      });
    }
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: 'Search your location',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
