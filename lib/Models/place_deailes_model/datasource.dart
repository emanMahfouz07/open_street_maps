import 'raw.dart';

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;
  Raw? raw;

  Datasource({
    this.sourcename,
    this.attribution,
    this.license,
    this.url,
    this.raw,
  });

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
    sourcename: json['sourcename'] as String?,
    attribution: json['attribution'] as String?,
    license: json['license'] as String?,
    url: json['url'] as String?,
    raw:
        json['raw'] == null
            ? null
            : Raw.fromJson(json['raw'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'sourcename': sourcename,
    'attribution': attribution,
    'license': license,
    'url': url,
    'raw': raw?.toJson(),
  };
}
