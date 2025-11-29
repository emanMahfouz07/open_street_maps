class Raw {
  String? name;
  String? type;
  String? email;
  String? place;
  int? osmId;
  String? nameAr;
  String? nameCs;
  String? nameDe;
  String? nameEn;
  String? nameEs;
  String? nameFa;
  String? nameFr;
  String? nameHe;
  String? nameHi;
  String? nameHy;
  String? nameMl;
  String? nameUk;
  String? nameUr;
  String? website;
  String? boundary;
  String? osmType;
  String? wikidata;
  String? wikipedia;
  int? population;
  String? placeName;
  int? adminLevel;
  String? altNameUk;
  String? countryCode;
  String? linkedPlace;
  String? placeNameAr;
  String? placeNameEn;
  String? placeNameHr;
  String? placeNameMl;
  String? placeNameZh;
  String? wikimediaCommons;
  String? placeAltNameUk;

  Raw({
    this.name,
    this.type,
    this.email,
    this.place,
    this.osmId,
    this.nameAr,
    this.nameCs,
    this.nameDe,
    this.nameEn,
    this.nameEs,
    this.nameFa,
    this.nameFr,
    this.nameHe,
    this.nameHi,
    this.nameHy,
    this.nameMl,
    this.nameUk,
    this.nameUr,
    this.website,
    this.boundary,
    this.osmType,
    this.wikidata,
    this.wikipedia,
    this.population,
    this.placeName,
    this.adminLevel,
    this.altNameUk,
    this.countryCode,
    this.linkedPlace,
    this.placeNameAr,
    this.placeNameEn,
    this.placeNameHr,
    this.placeNameMl,
    this.placeNameZh,
    this.wikimediaCommons,
    this.placeAltNameUk,
  });

  factory Raw.fromJson(Map<String, dynamic> json) => Raw(
    name: json['name'] as String?,
    type: json['type'] as String?,
    email: json['email'] as String?,
    place: json['place'] as String?,
    osmId: json['osm_id'] as int?,
    nameAr: json['name:ar'] as String?,
    nameCs: json['name:cs'] as String?,
    nameDe: json['name:de'] as String?,
    nameEn: json['name:en'] as String?,
    nameEs: json['name:es'] as String?,
    nameFa: json['name:fa'] as String?,
    nameFr: json['name:fr'] as String?,
    nameHe: json['name:he'] as String?,
    nameHi: json['name:hi'] as String?,
    nameHy: json['name:hy'] as String?,
    nameMl: json['name:ml'] as String?,
    nameUk: json['name:uk'] as String?,
    nameUr: json['name:ur'] as String?,
    website: json['website'] as String?,
    boundary: json['boundary'] as String?,
    osmType: json['osm_type'] as String?,
    wikidata: json['wikidata'] as String?,
    wikipedia: json['wikipedia'] as String?,
    population: json['population'] as int?,
    placeName: json['_place_name'] as String?,
    adminLevel: json['admin_level'] as int?,
    altNameUk: json['alt_name:uk'] as String?,
    countryCode: json['country_code'] as String?,
    linkedPlace: json['linked_place'] as String?,
    placeNameAr: json['_place_name:ar'] as String?,
    placeNameEn: json['_place_name:en'] as String?,
    placeNameHr: json['_place_name:hr'] as String?,
    placeNameMl: json['_place_name:ml'] as String?,
    placeNameZh: json['_place_name:zh'] as String?,
    wikimediaCommons: json['wikimedia_commons'] as String?,
    placeAltNameUk: json['_place_alt_name:uk'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'email': email,
    'place': place,
    'osm_id': osmId,
    'name:ar': nameAr,
    'name:cs': nameCs,
    'name:de': nameDe,
    'name:en': nameEn,
    'name:es': nameEs,
    'name:fa': nameFa,
    'name:fr': nameFr,
    'name:he': nameHe,
    'name:hi': nameHi,
    'name:hy': nameHy,
    'name:ml': nameMl,
    'name:uk': nameUk,
    'name:ur': nameUr,
    'website': website,
    'boundary': boundary,
    'osm_type': osmType,
    'wikidata': wikidata,
    'wikipedia': wikipedia,
    'population': population,
    '_place_name': placeName,
    'admin_level': adminLevel,
    'alt_name:uk': altNameUk,
    'country_code': countryCode,
    'linked_place': linkedPlace,
    '_place_name:ar': placeNameAr,
    '_place_name:en': placeNameEn,
    '_place_name:hr': placeNameHr,
    '_place_name:ml': placeNameMl,
    '_place_name:zh': placeNameZh,
    'wikimedia_commons': wikimediaCommons,
    '_place_alt_name:uk': placeAltNameUk,
  };
}
