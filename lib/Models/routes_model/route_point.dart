class Waypoint {
  // note: some APIs use [lon, lat] inside location, others return lat/lon fields
  List<num>? location; // [lon, lat] most likely in your JSON
  int? originalIndex;
  num? lat;
  num? lon;

  Waypoint({this.location, this.originalIndex, this.lat, this.lon});

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      location:
          (json['location'] as List<dynamic>?)?.map((e) => e as num).toList(),
      originalIndex: json['original_index'] as int?,
      lat: json['lat'] as num?,
      lon: json['lon'] as num?,
    );
  }
}
