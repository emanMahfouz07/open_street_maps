import 'package:maps/Models/routes_model/route_feature.dart';
import 'package:maps/Models/routes_model/route_properties.dart';

class RouteFeatureCollection {
  String? type;
  List<RouteFeature>? features;
  RouteProperties? properties;

  RouteFeatureCollection({this.type, this.features, this.properties});

  factory RouteFeatureCollection.fromJson(Map<String, dynamic> json) {
    return RouteFeatureCollection(
      type: json['type'] as String?,
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => RouteFeature.fromJson(e as Map<String, dynamic>))
              .toList(),
      properties:
          json['properties'] != null
              ? RouteProperties.fromJson(
                json['properties'] as Map<String, dynamic>,
              )
              : null,
    );
  }
}
