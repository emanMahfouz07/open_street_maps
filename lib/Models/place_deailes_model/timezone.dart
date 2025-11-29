class Timezone {
  String? name;
  String? offsetStd;
  int? offsetStdSeconds;
  String? offsetDst;
  int? offsetDstSeconds;
  String? abbreviationStd;
  String? abbreviationDst;

  Timezone({
    this.name,
    this.offsetStd,
    this.offsetStdSeconds,
    this.offsetDst,
    this.offsetDstSeconds,
    this.abbreviationStd,
    this.abbreviationDst,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    name: json['name'] as String?,
    offsetStd: json['offset_STD'] as String?,
    offsetStdSeconds: json['offset_STD_seconds'] as int?,
    offsetDst: json['offset_DST'] as String?,
    offsetDstSeconds: json['offset_DST_seconds'] as int?,
    abbreviationStd: json['abbreviation_STD'] as String?,
    abbreviationDst: json['abbreviation_DST'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'offset_STD': offsetStd,
    'offset_STD_seconds': offsetStdSeconds,
    'offset_DST': offsetDst,
    'offset_DST_seconds': offsetDstSeconds,
    'abbreviation_STD': abbreviationStd,
    'abbreviation_DST': abbreviationDst,
  };
}
