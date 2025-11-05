class Bbox {
  double? lon1;
  double? lat1;
  double? lon2;
  double? lat2;

  Bbox({this.lon1, this.lat1, this.lon2, this.lat2});

  factory Bbox.fromJson(Map<String, dynamic> json) => Bbox(
    lon1: (json['lon1'] as num?)?.toDouble(),
    lat1: (json['lat1'] as num?)?.toDouble(),
    lon2: (json['lon2'] as num?)?.toDouble(),
    lat2: (json['lat2'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'lon1': lon1,
    'lat1': lat1,
    'lon2': lon2,
    'lat2': lat2,
  };
}
