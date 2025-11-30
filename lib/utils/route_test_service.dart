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
        print('✅ JSON decoded successfully');

        final routeCollection = RouteFeatureCollection.fromJson(jsonData);
        print('📋 Features count: ${routeCollection.features?.length ?? 0}');

        // Extract the geometry from the first feature
        if (routeCollection.features != null &&
            routeCollection.features!.isNotEmpty) {
          final feature = routeCollection.features!.first;
          final geometry = feature.geometry;

          print('🗺️ Geometry type: ${geometry?.type}');
          print('📍 Coordinates type: ${geometry?.coordinates.runtimeType}');

          if (geometry?.coordinates != null) {
            print(
              '📏 Coordinates length: ${(geometry!.coordinates as List).length}',
            );
            print(
              '🔍 First coordinate sample: ${(geometry.coordinates as List).first}',
            );
          }

          // Convert geometry to LatLng points
          final points = geometryToLatLngs(geometry);

          print('✅ FINAL RESULT: ${points.length} LatLng points');
          if (points.isNotEmpty) {
            print('   First point: ${points.first}');
            print('   Last point: ${points.last}');
          }
          print('========== ROUTING DEBUG END ==========\n');

          return points;
        }

        print('⚠️ No features found in response');
        print('========== ROUTING DEBUG END ==========\n');
        return [];
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        print('   Response body: ${response.body}');
        print('========== ROUTING DEBUG END ==========\n');
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('❌ EXCEPTION in getRoute: $e');
      print('   Stack trace: $stackTrace');
      print('========== ROUTING DEBUG END ==========\n');
      throw Exception('Error fetching route: $e');
    }
  }
}
