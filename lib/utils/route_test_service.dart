import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:maps/Models/routes_model/geometry.dart';
import 'package:maps/Models/routes_model/routes_model.dart';

class RoutingService {
  static const String _baseUrl = 'https://api.geoapify.com/v1/routing';
  final String apiKey = '29e466b51aed4732a5cef3f4aeec458a';

  RoutingService();
  Future<List<LatLng>> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final waypoints =
          '${origin.latitude},${origin.longitude}|${destination.latitude},${destination.longitude}';

      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'waypoints': waypoints,
          'mode': 'drive',
          'apiKey': apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final routeCollection = RouteFeatureCollection.fromJson(jsonData);

        // Extract the geometry from the first feature
        if (routeCollection.features != null &&
            routeCollection.features!.isNotEmpty) {
          final geometry = routeCollection.features!.first.geometry;

          // Convert geometry to LatLng points
          return geometryToLatLngs(geometry);
        }

        return [];
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching route: $e');
    }
  }

  Future<RouteFeatureCollection?> getRouteDetails({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final waypoints =
          '${origin.latitude},${origin.longitude}|${destination.latitude},${destination.longitude}';

      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'waypoints': waypoints,
          'mode': 'drive',
          'apiKey': apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RouteFeatureCollection.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching route: $e');
    }
  }
}
