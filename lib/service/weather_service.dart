import 'dart:convert';

// import 'package:geocoding/geocoding.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String apiKey = '598fb93a64d907b8c4d7aa33156cb459';

// fetch weather data from API
  Future<Weather> getWeather(String city) async {
    final response = await http
        .get(Uri.parse("$baseUrl?q=$city&appid=$apiKey&units=metric"));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

// function for get user current city
  Future<String> getCity() async {
    //get location permission from user
    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    // }

    // // get current location
    // Position position = await Geolocator.getCurrentPosition(
    //   locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    // );

    // // convert latitude and longitude to city name
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);

    //extrack the city name from the placemarks
    String? city = "delhi";

    return city;
  }
}
