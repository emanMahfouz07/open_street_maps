import 'bbox.dart';
import 'datasource.dart';
import 'rank.dart';
import 'timezone.dart';

class GeoPlaceModel {
  Datasource? datasource;
  String? country;
  String? countryCode;
  String? state;
  String? city;
  String? village;
  String? postcode;
  String? district;
  String? suburb;
  String? street;
  String? housenumber;
  String? iso31662;
  double? lon;
  double? lat;
  String? stateCode;
  String? resultType;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  Timezone? timezone;
  String? plusCode;
  String? plusCodeShort;
  Rank? rank;
  String? placeId;
  Bbox? bbox;

  GeoPlaceModel({
    this.datasource,
    this.country,
    this.countryCode,
    this.state,
    this.city,
    this.village,
    this.postcode,
    this.district,
    this.suburb,
    this.street,
    this.housenumber,
    this.iso31662,
    this.lon,
    this.lat,
    this.stateCode,
    this.resultType,
    this.formatted,
    this.addressLine1,
    this.addressLine2,
    this.timezone,
    this.plusCode,
    this.plusCodeShort,
    this.rank,
    this.placeId,
    this.bbox,
  });

  factory GeoPlaceModel.fromJson(Map<String, dynamic> json) => GeoPlaceModel(
    datasource:
        json['datasource'] == null
            ? null
            : Datasource.fromJson(json['datasource'] as Map<String, dynamic>),
    country: json['country'] as String?,
    countryCode: json['country_code'] as String?,
    state: json['state'] as String?,
    city: json['city'] as String?,
    village: json['village'] as String?,
    postcode: json['postcode'] as String?,
    district: json['district'] as String?,
    suburb: json['suburb'] as String?,
    street: json['street'] as String?,
    housenumber: json['housenumber'] as String?,
    iso31662: json['iso3166_2'] as String?,
    lon: (json['lon'] as num?)?.toDouble(),
    lat: (json['lat'] as num?)?.toDouble(),
    stateCode: json['state_code'] as String?,
    resultType: json['result_type'] as String?,
    formatted: json['formatted'] as String?,
    addressLine1: json['address_line1'] as String?,
    addressLine2: json['address_line2'] as String?,
    timezone:
        json['timezone'] == null
            ? null
            : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
    plusCode: json['plus_code'] as String?,
    plusCodeShort: json['plus_code_short'] as String?,
    rank:
        json['rank'] == null
            ? null
            : Rank.fromJson(json['rank'] as Map<String, dynamic>),
    placeId: json['place_id'] as String?,
    bbox:
        json['bbox'] == null
            ? null
            : Bbox.fromJson(json['bbox'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'datasource': datasource?.toJson(),
    'country': country,
    'country_code': countryCode,
    'state': state,
    'city': city,
    'village': village,
    'postcode': postcode,
    'district': district,
    'suburb': suburb,
    'street': street,
    'housenumber': housenumber,
    'iso3166_2': iso31662,
    'lon': lon,
    'lat': lat,
    'state_code': stateCode,
    'result_type': resultType,
    'formatted': formatted,
    'address_line1': addressLine1,
    'address_line2': addressLine2,
    'timezone': timezone?.toJson(),
    'plus_code': plusCode,
    'plus_code_short': plusCodeShort,
    'rank': rank?.toJson(),
    'place_id': placeId,
    'bbox': bbox?.toJson(),
  };
}
