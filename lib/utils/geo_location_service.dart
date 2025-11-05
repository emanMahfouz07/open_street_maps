import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class GeoLocationService {
  final String apiKey = '29e466b51aed4732a5cef3f4aeec458a';
  Future<List<GeoPlaceModel>> autoComplete({required String text}) async {
    var response = await http.get(
      Uri.parse(
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$text&format=json&apiKey=$apiKey',
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
}
