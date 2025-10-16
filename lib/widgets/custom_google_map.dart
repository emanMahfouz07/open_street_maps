import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition intialCameraPosition;
  @override
  void initState() {
    intialCameraPosition = const CameraPosition(
      target: LatLng(30.797758433391955, 30.998669854455613),
      zoom: 12,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          cameraTargetBounds: CameraTargetBounds(
            LatLngBounds(
              southwest: LatLng(30.737603490395255, 30.80724974493715),
              northeast: LatLng(30.843966903367015, 31.187772708180105),
            ),
          ),
          initialCameraPosition: intialCameraPosition,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Change Location'),
          ),
        ),
      ],
    );
  }
}
