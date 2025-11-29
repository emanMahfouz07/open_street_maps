import 'package:maps/Models/routes_model/geometry.dart';
import 'package:maps/Models/routes_model/route_properties.dart';

class RouteFeature {
  String? type;
  RouteProperties? properties;
  Geometry? geometry;

  RouteFeature({this.type, this.properties, this.geometry});

  factory RouteFeature.fromJson(Map<String, dynamic> json) {
    return RouteFeature(
      type: json['type'] as String?,
      properties:
          json['properties'] != null
              ? RouteProperties.fromJson(
                json['properties'] as Map<String, dynamic>,
              )
              : null,
      geometry:
          json['geometry'] != null
              ? Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
              : null,
    );
  }
}
