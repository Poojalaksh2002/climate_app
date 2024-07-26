import 'package:geolocator/geolocator.dart';

import '../utils/constants.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Networking networking =
        new Networking('$baseUrl?q=$cityName&appid=$API_KEY&units=metric');
    var cityWeatherData = await networking.fetchData();

    print("CittyDataModel::$cityWeatherData");
    return cityWeatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location loc = Location();
    Position resPosition = await loc.getCurrentLocation();

    double latitudeResult = await loc.latitude!;
    double longitudeResult = await loc.longitude!;

    Networking networking = new Networking(
        '$baseUrl?lat=$latitudeResult&lon=$longitudeResult&appid=$API_KEY&units=metric');
    var weatherData = await networking.fetchData();
    print(weatherData);
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
