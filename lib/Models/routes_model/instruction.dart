class Instruction {
  String? text;
  Instruction({this.text});
  factory Instruction.fromJson(Map<String, dynamic> json) =>
      Instruction(text: json['text'] as String?);
}
