// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:latlong2/latlong.dart';
// import 'package:maps/Models/routes_model/geometry.dart';

// class RouteService {
//   final String apiKey = '29e466b51aed4732a5cef3f4aeec458a';
//   final String baseUrl = 'https://api.geoapify.com';

//   Future<Geometry?> getRouteGeometry({
//     required LatLng origin,
//     required LatLng destination,
//     String mode = 'drive',
//     Map<String, String>? extraParams,
//   }) async {
//     final waypointsString =
//         '${origin.longitude},${origin.latitude}|${destination.longitude},${destination.latitude}';

//     final params = {
//       'waypoints': waypointsString,
//       'mode': mode,
//       'apiKey': apiKey,
//       if (extraParams != null) ...extraParams,
//     };

//     final uri = Uri.parse(
//       '$baseUrl/v1/routing',
//     ).replace(queryParameters: params);
//     final resp = await http.get(uri);

//     if (resp.statusCode != 200) {
//       throw Exception('Routing API returned ${resp.statusCode}: ${resp.body}');
//     }

//     final jsonBody = jsonDecode(resp.body) as Map<String, dynamic>?;

//     if (jsonBody == null) return null;
//     final features = (jsonBody['features'] as List<dynamic>?) ?? [];
//     if (features.isEmpty) return null;

//     final geometryJson =
//         (features.first as Map<String, dynamic>)['geometry']
//             as Map<String, dynamic>?;
//     if (geometryJson == null) return null;

//     return Geometry.fromJson(geometryJson);
//   }

//   Future<List<List<LatLng>>> getRoutePolylines({
//     required LatLng origin,
//     required LatLng destination,
//     String mode = 'drive',
//     Map<String, String>? extraParams,
//   }) async {
//     final waypointsString =
//         '${origin.longitude},${origin.latitude}|${destination.longitude},${destination.latitude}';

//     final params = <String, String>{
//       'waypoints': waypointsString,
//       'mode': mode,
//       'apiKey': apiKey,
//       if (extraParams != null) ...extraParams,
//     };

//     final uri = Uri.parse(
//       '$baseUrl/v1/routing',
//     ).replace(queryParameters: params);
//     print('ROUTE REQUEST URI: $uri');

//     final resp = await http.get(uri);
//     print('ROUTE STATUS: ${resp.statusCode}');
//     print(
//       'ROUTE BODY (truncated): ${resp.body.length > 1000 ? resp.body.substring(0, 1000) + "..." : resp.body}',
//     );

//     if (resp.statusCode != 200) {
//       throw Exception('Routing API returned ${resp.statusCode}: ${resp.body}');
//     }

//     final jsonBody = jsonDecode(resp.body) as Map<String, dynamic>?;
//     final features = (jsonBody?['features'] as List<dynamic>?) ?? [];
//     print('features count: ${features.length}');

//     final List<List<LatLng>> parts = [];
//     for (final f in features) {
//       final geom =
//           (f as Map<String, dynamic>)['geometry'] as Map<String, dynamic>?;
//       if (geom == null) continue;

//       final type = geom['type'];
//       final coords = geom['coordinates'];

//       if (type == 'MultiLineString' && coords is List) {
//         for (final part in coords) {
//           if (part is List) {
//             final pts = <LatLng>[];
//             for (final point in part) {
//               if (point is List && point.length >= 2) {
//                 final lon = (point[0] as num).toDouble();
//                 final lat = (point[1] as num).toDouble();
//                 pts.add(LatLng(lat, lon));
//               }
//             }
//             if (pts.isNotEmpty) {
//               parts.add(pts);
//               print('added part with ${pts.length} points');
//             }
//           }
//         }
//       } else if (type == 'LineString' && coords is List) {
//         final pts = <LatLng>[];
//         for (final point in coords) {
//           if (point is List && point.length >= 2) {
//             final lon = (point[0] as num).toDouble();
//             final lat = (point[1] as num).toDouble();
//             pts.add(LatLng(lat, lon));
//           }
//         }
//         if (pts.isNotEmpty) {
//           parts.add(pts);
//           print('added LineString with ${pts.length} points');
//         }
//       } else {
//         // fallback try
//         if (coords is List) {
//           final pts = <LatLng>[];
//           for (final item in coords) {
//             if (item is List && item.length >= 2) {
//               final lon = (item[0] as num).toDouble();
//               final lat = (item[1] as num).toDouble();
//               pts.add(LatLng(lat, lon));
//             }
//           }
//           if (pts.isNotEmpty) {
//             parts.add(pts);
//             print('added fallback part with ${pts.length} points');
//           }
//         }
//       }
//     }

//     print('TOTAL PARTS RETURNED: ${parts.length}');
//     return parts;
//   }
// }
