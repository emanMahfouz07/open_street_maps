import 'package:maps/Models/routes_model/instruction.dart';

class Step {
  int? fromIndex;
  int? toIndex;
  num? distance;
  num? time;
  Instruction? instruction;

  Step({
    this.fromIndex,
    this.toIndex,
    this.distance,
    this.time,
    this.instruction,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      fromIndex: json['from_index'] as int?,
      toIndex: json['to_index'] as int?,
      distance: json['distance'] as num?,
      time: json['time'] as num?,
      instruction:
          json['instruction'] != null
              ? Instruction.fromJson(
                json['instruction'] as Map<String, dynamic>,
              )
              : null,
    );
  }
}
