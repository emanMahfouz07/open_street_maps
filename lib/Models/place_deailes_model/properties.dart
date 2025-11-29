import 'contact.dart';
import 'datasource.dart';
import 'name_international.dart';
import 'timezone.dart';
import 'wiki_and_media.dart';

class Properties {
  String? featureType;
  String? website;
  String? name;
  NameInternational? nameInternational;
  Contact? contact;
  WikiAndMedia? wikiAndMedia;
  List<dynamic>? categories;
  Datasource? datasource;
  String? city;
  String? state;
  String? country;
  String? countryCode;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  double? lat;
  double? lon;
  String? iso31662;
  Timezone? timezone;
  String? placeId;

  Properties({
    this.featureType,
    this.website,
    this.name,
    this.nameInternational,
    this.contact,
    this.wikiAndMedia,
    this.categories,
    this.datasource,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.formatted,
    this.addressLine1,
    this.addressLine2,
    this.lat,
    this.lon,
    this.iso31662,
    this.timezone,
    this.placeId,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    featureType: json['feature_type'] as String?,
    website: json['website'] as String?,
    name: json['name'] as String?,
    nameInternational:
        json['name_international'] == null
            ? null
            : NameInternational.fromJson(
              json['name_international'] as Map<String, dynamic>,
            ),
    contact:
        json['contact'] == null
            ? null
            : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    wikiAndMedia:
        json['wiki_and_media'] == null
            ? null
            : WikiAndMedia.fromJson(
              json['wiki_and_media'] as Map<String, dynamic>,
            ),
    categories: json['categories'] as List<dynamic>?,
    datasource:
        json['datasource'] == null
            ? null
            : Datasource.fromJson(json['datasource'] as Map<String, dynamic>),
    city: json['city'] as String?,
    state: json['state'] as String?,
    country: json['country'] as String?,
    countryCode: json['country_code'] as String?,
    formatted: json['formatted'] as String?,
    addressLine1: json['address_line1'] as String?,
    addressLine2: json['address_line2'] as String?,
    lat: (json['lat'] as num?)?.toDouble(),
    lon: (json['lon'] as num?)?.toDouble(),
    iso31662: json['iso3166_2'] as String?,
    timezone:
        json['timezone'] == null
            ? null
            : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
    placeId: json['place_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'feature_type': featureType,
    'website': website,
    'name': name,
    'name_international': nameInternational?.toJson(),
    'contact': contact?.toJson(),
    'wiki_and_media': wikiAndMedia?.toJson(),
    'categories': categories,
    'datasource': datasource?.toJson(),
    'city': city,
    'state': state,
    'country': country,
    'country_code': countryCode,
    'formatted': formatted,
    'address_line1': addressLine1,
    'address_line2': addressLine2,
    'lat': lat,
    'lon': lon,
    'iso3166_2': iso31662,
    'timezone': timezone?.toJson(),
    'place_id': placeId,
  };
}
