import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LocationScreen extends StatefulWidget {
  final locationWeatherData;

  LocationScreen(this.locationWeatherData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var cityName;
  var temprature;
  String conditionIcon;
  String displayMessage;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    initControllers(widget.locationWeatherData);
  }

  initControllers(dynamic weatherData) {
    context.loaderOverlay.show();
    setState(
      () {
        if (weatherData == null) {
          cityName = '-';
          temprature = '404';
          conditionIcon = 'Error';
          displayMessage = 'Unable to get weather data';
          return;
        }

        var condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        temprature = (weatherData['main']['temp']).toInt();

        conditionIcon = weatherModel.getWeatherIcon(condition);
        displayMessage = weatherModel.getMessage(temprature);
      },
    );
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await WeatherModel().getLocationWeather(context);
                      initControllers(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (typedCityName != null) {
                        var cityWeatherData =
                            await weatherModel.getCityWeather(typedCityName);
                        print(cityWeatherData);
                        initControllers(cityWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Text(
                "$cityName",
                textAlign: TextAlign.center,
                style: kMessageTextStyle,
              ),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      conditionIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  displayMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
