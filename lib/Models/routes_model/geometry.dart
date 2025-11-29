import 'package:latlong2/latlong.dart';

class Geometry {
  String? type;
  dynamic coordinates;

  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'] as String?,
      coordinates: json['coordinates'],
    );
  }
}

List<LatLng> geometryToLatLngs(Geometry? geometry) {
  if (geometry == null || geometry.coordinates == null) return [];

  final coords = geometry.coordinates;

  if (geometry.type == 'MultiLineString' && coords is List) {
    final List<LatLng> out = [];
    for (final part in coords) {
      if (part is List) {
        for (final point in part) {
          if (point is List && point.length >= 2) {
            final lon = (point[0] as num).toDouble();
            final lat = (point[1] as num).toDouble();
            out.add(LatLng(lat, lon));
          }
        }
      }
    }
    return out;
  }

  if (geometry.type == 'LineString' && coords is List) {
    final List<LatLng> out = [];
    for (final point in coords) {
      if (point is List && point.length >= 2) {
        final lon = (point[0] as num).toDouble();
        final lat = (point[1] as num).toDouble();
        out.add(LatLng(lat, lon));
      }
    }
    return out;
  }

  // fallback: try to interpret as list of points directly
  if (coords is List) {
    final List<LatLng> out = [];
    try {
      for (final item in coords) {
        if (item is List && item.length >= 2) {
          final lon = (item[0] as num).toDouble();
          final lat = (item[1] as num).toDouble();
          out.add(LatLng(lat, lon));
        }
      }
    } catch (_) {}
    return out;
  }

  return [];
}
