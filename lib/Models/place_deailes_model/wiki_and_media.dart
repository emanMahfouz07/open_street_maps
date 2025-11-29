class WikiAndMedia {
  String? wikidata;
  String? wikipedia;
  String? wikimediaCommons;

  WikiAndMedia({this.wikidata, this.wikipedia, this.wikimediaCommons});

  factory WikiAndMedia.fromJson(Map<String, dynamic> json) => WikiAndMedia(
    wikidata: json['wikidata'] as String?,
    wikipedia: json['wikipedia'] as String?,
    wikimediaCommons: json['wikimedia_commons'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'wikidata': wikidata,
    'wikipedia': wikipedia,
    'wikimedia_commons': wikimediaCommons,
  };
}
