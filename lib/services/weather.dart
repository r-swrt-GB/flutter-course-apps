import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const String apiKey = '8bae72d4f586b2754baaa18055e44349';
const String openWeatherMapWeatherUrl =
    'https://api.openweathermap.org/data/2.5/weather';
const String openWeatherMapCityUrl =
    'https://api.openweathermap.org/geo/1.0/reverse';

class WeatherModel {
  var latitude;
  var longitude;

  LocationMethods location = LocationMethods();

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        '$openWeatherMapWeatherUrl?q=$cityName&appid=$apiKey&units=metric';

    NetworkHekper networkHelper = NetworkHekper(url);
    var weatherData = await networkHelper.getWeatherData();

    print(weatherData);

    return weatherData;
  }

  Future<dynamic> getLocationWeather(BuildContext context) async {
    await location.getLocation(context);

    //longitude and latitude info comes from previous location call
    latitude = location.latitude ?? '-';
    longitude = location.latitude ?? '-';

    NetworkHekper networkHelper = NetworkHekper(
        '$openWeatherMapWeatherUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    //'$openWeatherMapCityUrl?lat=$latitude&lon=$longitude&limit=1&appid=$apiKey');

    //Decoded Json with all weather data
    var weatherData = await networkHelper.getWeatherData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
