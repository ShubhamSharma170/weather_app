import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weather = WeatherService();
  Weather? _weatherModel;
  // fetch weather
  featchWeather() async {
    String cityName = await _weather.getCity();
    try {
      final weather = await _weather.getWeather(cityName);
      setState(() {
        _weatherModel = weather;
      });
    }
    // any error
    catch (e) {
      log(e.toString());
    }
  }

  // funcction for set weather condition icon
  String getWeatherIcon(String condition) {
    if (condition.isEmpty) return "asset/sunny.json";

    switch (condition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "asset/haze.json";
      case "rain":
      case "drizzle":
      case "shower rain":
      case "thunderstorm":
        return "asset/rain.json";
      case "clear":
        return "asset/sunny.json";
      default:
        return "asset/sunny.json";
    }
  }

  @override
  void initState() {
    featchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: _weatherModel == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_weatherModel!.cityName,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Lottie.asset(getWeatherIcon(_weatherModel!.condition)),
                    Text(_weatherModel!.description,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text("${_weatherModel!.temperature}°C",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text(
                      "${_weatherModel!.windSpeed}meter/sec",
                    ),
                  ],
                )),
    );
  }
}
