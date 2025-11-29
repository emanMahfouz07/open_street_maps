import 'feature.dart';

class PlaceDeailesModel {
  String? type;
  List<Feature>? features;

  PlaceDeailesModel({this.type, this.features});

  factory PlaceDeailesModel.fromJson(Map<String, dynamic> json) {
    return PlaceDeailesModel(
      type: json['type'] as String?,
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => Feature.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'features': features?.map((e) => e.toJson()).toList(),
  };
}
