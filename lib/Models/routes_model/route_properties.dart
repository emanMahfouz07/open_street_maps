import 'package:maps/Models/routes_model/leg.dart';
import 'package:maps/Models/routes_model/route_point.dart';

class RouteProperties {
  String? mode;
  List<Waypoint>? waypoints;
  String? units;
  num? distance;
  String? distanceUnits;
  num? time;
  List<Leg>? legs;

  RouteProperties({
    this.mode,
    this.waypoints,
    this.units,
    this.distance,
    this.distanceUnits,
    this.time,
    this.legs,
  });

  factory RouteProperties.fromJson(Map<String, dynamic> json) {
    return RouteProperties(
      mode: json['mode'] as String?,
      waypoints:
          (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList(),
      units: json['units'] as String?,
      distance: json['distance'] as num?,
      distanceUnits: json['distance_units'] as String?,
      time: json['time'] as num?,
      legs:
          (json['legs'] as List<dynamic>?)
              ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
