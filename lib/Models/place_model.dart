import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latlong;
  PlaceModel({required this.id, required this.name, required this.latlong});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'أسواق فتح الله',
    latlong: LatLng(30.79798809833723, 31.00773837457071),
  ),
  PlaceModel(
    id: 2,
    name: 'Town Team',
    latlong: LatLng(30.799425519394767, 31.009103753188043),
  ),
  PlaceModel(
    id: 3,
    name: 'مطعم ختعم',
    latlong: LatLng(30.787615198610652, 30.99736623261863),
  ),
];
