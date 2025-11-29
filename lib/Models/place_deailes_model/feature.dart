import 'properties.dart';

class Feature {
  String? type;
  Properties? properties;

  Feature({this.type, this.properties});

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: json['type'] as String?,
    properties:
        json['properties'] == null
            ? null
            : Properties.fromJson(json['properties'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'properties': properties?.toJson(),
  };
}
