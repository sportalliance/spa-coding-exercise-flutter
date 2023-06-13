import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_coding_exercise/util/array_util.dart';

class MapBoxService {
  static String accessToken = "";

  static Future<List<MapBoxPlace>?> searchPlaces(String searchQuery,
      [int limit = 6]) async {
    List<MapBoxPlace> result = [];
    final requestUri = Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$searchQuery"
        ".json?access_token=$accessToken&autocomplete=true&country=de&types=place&limit=$limit");

    final response = await http.get(requestUri);

    try {
      var decodedJson = jsonDecode(response.body);
      var features = decodedJson["features"];
      if (ArrayUtil.isNotEmpty(features)) {
        for (dynamic place in features) {
          var mapBoxPlace = MapBoxPlace.fromJson(place);
          result.add(mapBoxPlace);
        }
      }
    } catch (err) {
      print(err);
    }

    return result;
  }

  static Future<MapBoxPlace?> lookup(double latitude, double longitude) async {
    final requestUri = Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude"
        ".json?access_token=$accessToken&types=region");

    final response = await http.get(requestUri);

    try {
      var decodedJson = jsonDecode(response.body);
      var features = decodedJson["features"];
      if (ArrayUtil.isNotEmpty(features)) {
        for (dynamic place in features) {
          return MapBoxPlace.fromJson(place);
        }
      }
    } catch (err) {
      print(err);
    }

    return null;
  }
}

class MapBoxPlace {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  MapBoxPlace.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['text'],
        latitude = double.parse(json['center'][1].toString()),
        longitude = double.parse(json['center'][0].toString());
}
