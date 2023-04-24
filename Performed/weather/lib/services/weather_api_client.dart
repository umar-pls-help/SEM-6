import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weather_app/models/weathermodel.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        //Api id is the api key for the user and $location we use to get the location input by the user and units is metric. We can use metric & standard units here
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=06045d3bf3b9e6fc3b65a0d1b3485eea&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    // print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
