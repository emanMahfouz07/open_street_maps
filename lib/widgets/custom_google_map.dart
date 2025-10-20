import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/Models/place_model.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Set<Marker> markers = {};
  late CameraPosition intialCameraPosition;
  late GoogleMapController googleMapController;
  String? mapStyle;

  @override
  void initState() {
    super.initState();

    intialCameraPosition = const CameraPosition(
      target: LatLng(30.797758433391955, 30.998669854455613),
      zoom: 12,
    );

    rootBundle.loadString('assets/map_styles/night_map_style.json').then((
      style,
    ) {
      setState(() {
        mapStyle = style;
      });
    });
    initMarkers();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          style: mapStyle,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          initialCameraPosition: intialCameraPosition,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              CameraPosition newLocation = const CameraPosition(
                target: LatLng(30.843966903367015, 31.187772708180105),
                zoom: 14,
              );
              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(newLocation),
              );
            },
            child: Text('Change Location'),
          ),
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

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      'assets/Images/icons8-marker-100.png',
    );
    var myMarkers =
        places
            .map(
              (placeModel) => Marker(
                icon: customMarkerIcon,
                markerId: MarkerId(placeModel.id.toString()),
                position: placeModel.latlong,
                infoWindow: InfoWindow(title: placeModel.name),
              ),
            )
            .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}
