import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'package:maps/utils/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition intialCameraPosition;
  GoogleMapController? googleMapController;
  bool isFirstCall = true;
  String? mapStyle;

  late LocationService locationService;
  @override
  void initState() {
    super.initState();

    locationService = LocationService();
    intialCameraPosition = const CameraPosition(
      target: LatLng(30.797758433391955, 30.998669854455613),
      zoom: 1,
    );

    rootBundle.loadString('assets/map_styles/night_map_style.json').then((
      style,
    ) {
      setState(() {
        mapStyle = style;
      });
    });
    //  initMarkers();
    // initPolylines();
    updataMyLocation();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polylines,
          zoomControlsEnabled: false,
          markers: markers,
          style: mapStyle,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          initialCameraPosition: intialCameraPosition,
        ),
      ],
    );
  }

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageDate = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageDate.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFrame = await imageCodec.getNextFrame();
    var imageByteDate = await imageFrame.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return imageByteDate!.buffer.asUint8List();
  }

  // void initMarkers() async {
  //   var byteData = await getImageFromRawData('assets/images/marker.png', 120);
  //   var customMarkerIcon = BitmapDescriptor.fromBytes(byteData);
  //   var myMarkers =
  //       places
  //           .map(
  //             (placeModel) => Marker(
  //               icon: customMarkerIcon,
  //               markerId: MarkerId(placeModel.id.toString()),
  //               position: placeModel.latlong,
  //               infoWindow: InfoWindow(title: placeModel.name),
  //             ),
  //           )
  //           .toSet();
  //   markers.addAll(myMarkers);
  //   setState(() {});
  // }

  void initPolylines() {
    Polyline polyline = Polyline(
      consumeTapEvents: true,
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.78681328298671, 31.000135711527065),
        LatLng(30.936762242036018, 31.02402559998755),
        LatLng(30.922735382670254, 31.12576591179064),
        LatLng(30.969446715747196, 31.167002601919393),
      ],
      color: Colors.blue,
      width: 5,
      startCap: Cap.roundCap,
      patterns: [PatternItem.gap(20)],
    );

    polylines.add(polyline);
  }

  void updataMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        setMyLocationMarker(locationData);
        updateMycamera(locationData);
      });
    }
  }

  void updateMycamera(LocationData locationData) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17,
      );
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  void setMyLocationMarker(LocationData locationData) {
    Marker myLocationMarker = Marker(
      markerId: const MarkerId('my_location'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }
}

// getLocationData(); //مش هنعمل await عشان مفيش حاجة بعدها تعتمد عليها
