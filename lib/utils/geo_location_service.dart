import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';
import 'package:maps/Models/place_deailes_model/properties.dart';
import 'package:maps/utils/apis.dart';

class GeoLocationService {
  final String apiKey = APIKEY.mapsApiKey;
  final String baseUrl = 'https://api.geoapify.com';
  Future<List<GeoPlaceModel>> autoComplete({required String text}) async {
    var response = await http.get(
      Uri.parse(
        '$baseUrl/v1/geocode/autocomplete?text=$text&format=json&apiKey=$apiKey',
      ),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      List<GeoPlaceModel> places = [];
      for (var item in data) {
        places.add(GeoPlaceModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception('Failed to load autocomplete data');
    }
  }

  Future<Properties> getPlaceDetails({required String placeId}) async {
    var response = await http.get(
      Uri.parse('$baseUrl/v2/place-details?id=$placeId&apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['features'][0]["properties"];

      return Properties.fromJson(data);
    } else {
      throw Exception('Failed to load place details: ${response.statusCode}');
    }
  }
}
