import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_coding_exercise/util/array_util.dart';

class MapBoxService {

  static String accessToken = "";

  static Future<List<MapBoxPlace>> searchPlaces(String searchQuery, [int limit = 6]) async {
    List<MapBoxPlace> result = [];
    var response = await http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$searchQuery"
        ".json?access_token=$accessToken&autocomplete=true&country=de&types=place&limit=$limit");

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

    return (ArrayUtil.isNotEmpty(result)) ? result : null;
  }

  static Future<MapBoxPlace> lookup(double latitude, double longitude) async {
    var response = await http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude"
        ".json?access_token=$accessToken&types=region");

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
  String id;
  String name;
  double latitude;
  double longitude;

  MapBoxPlace.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['text'];
    latitude = double.parse(json['center'][1].toString());
    longitude = double.parse(json['center'][0].toString());
  }
}
