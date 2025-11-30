import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:maps/Models/routes_model/geometry.dart';
import 'package:maps/Models/routes_model/routes_model.dart';
import 'package:maps/utils/apis.dart';

class RoutingService {
  static const String _baseUrl = 'https://api.geoapify.com/v1/routing';
  final String apiKey = APIKEY.mapsApiKey;

  RoutingService();

  Future<List<LatLng>> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      print('\n========== ROUTING DEBUG START ==========');
      print('🚀 Origin: ${origin.latitude}, ${origin.longitude}');
      print(
        '🎯 Destination: ${destination.latitude}, ${destination.longitude}',
      );

      // Build the URL with waypoints
      final waypoints =
          '${origin.latitude},${origin.longitude}|${destination.latitude},${destination.longitude}';

      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'waypoints': waypoints,
          'mode': 'drive',
          'apiKey': apiKey,
        },
      );

      print('🌐 Request URL: $uri');

      // Make the HTTP request
      final response = await http.get(uri);

      print('📡 Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Print raw response for debugging
        print('📦 Raw Response Body (first 500 chars):');
        print(
          response.body.substring(
            0,
            response.body.length > 500 ? 500 : response.body.length,
          ),
        );

        // Parse the response
        final jsonData = json.decode(response.body);

        final routeCollection = RouteFeatureCollection.fromJson(jsonData);

        if (routeCollection.features != null &&
            routeCollection.features!.isNotEmpty) {
          final feature = routeCollection.features!.first;
          final geometry = feature.geometry;

          final points = geometryToLatLngs(geometry);

          return points;
        }

        return [];
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      throw Exception('Error fetching route: $e');
    }
  }
}
