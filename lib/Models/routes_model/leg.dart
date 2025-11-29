import 'package:maps/Models/routes_model/step.dart';

class Leg {
  num? distance;
  num? time;
  List<Step>? steps;

  Leg({this.distance, this.time, this.steps});

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      distance: json['distance'] as num?,
      time: json['time'] as num?,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
