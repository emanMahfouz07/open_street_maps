class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
    sourcename: json['sourcename'] as String?,
    attribution: json['attribution'] as String?,
    license: json['license'] as String?,
    url: json['url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'sourcename': sourcename,
    'attribution': attribution,
    'license': license,
    'url': url,
  };
}
