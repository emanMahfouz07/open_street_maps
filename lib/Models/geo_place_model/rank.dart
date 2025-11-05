class Rank {
  double? importance;
  int? confidence;
  int? confidenceCityLevel;
  int? confidenceStreetLevel;
  int? confidenceBuildingLevel;
  String? matchType;

  Rank({
    this.importance,
    this.confidence,
    this.confidenceCityLevel,
    this.confidenceStreetLevel,
    this.confidenceBuildingLevel,
    this.matchType,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
    importance: (json['importance'] as num?)?.toDouble(),
    confidence: json['confidence'] as int?,
    confidenceCityLevel: json['confidence_city_level'] as int?,
    confidenceStreetLevel: json['confidence_street_level'] as int?,
    confidenceBuildingLevel: json['confidence_building_level'] as int?,
    matchType: json['match_type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'importance': importance,
    'confidence': confidence,
    'confidence_city_level': confidenceCityLevel,
    'confidence_street_level': confidenceStreetLevel,
    'confidence_building_level': confidenceBuildingLevel,
    'match_type': matchType,
  };
}
