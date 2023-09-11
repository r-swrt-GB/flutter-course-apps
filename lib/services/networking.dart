import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHekper {
  NetworkHekper(this.weatherDataUrl);
  final String weatherDataUrl;
  //final String cityDataUrl;

  var condition;
  var cityName;
  var temprature;

  Future getWeatherData() async {
    http.Response weatherDataResponse;
    http.Response cityResponse;
    //Catch all error that can occur on network
    try {
      weatherDataResponse = await http.get(Uri.parse(weatherDataUrl));
      //cityResponse = await http.get(Uri.parse(cityDataUrl));
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        return print(
            'Could not connect to server. Please check your connection and try again.');
      } else {
        return print('An error has occured. Please try again later');
      }
    }

    //Catch errors than can occur on http request
    //Status code 200 = OK
    //Status code 400 = Bad Request (You sent something bad)
    if (weatherDataResponse.statusCode == 200) {
      String data = weatherDataResponse.body;
      var decodedData = jsonDecode(data);
      // String cityData = cityResponse.body;
      //var decodedCityData = jsonDecode(cityData);
      // print(decodedCityData[0]['name']);

      return decodedData;
    } else if (weatherDataResponse.statusCode == 400) {
      print(
          'Weather information for the specific location could not be found. Please try again later.');
    } else {
      print(weatherDataResponse.statusCode);
    }
  }

  jsonToData(String data) {}
}
