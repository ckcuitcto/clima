import '../services/location.dart';
import '../services/networking.dart';
import 'networking.dart';

const apiKey = 'aa106531c7232c4d354ec0ceeef8c218';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
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
  Future<dynamic> getLocationData() async {
    Location location = Location();
    bool checkActiveLocationSetting = await location.activeOrNot();
    if(checkActiveLocationSetting) {
      await location.getCurrentLocation();
      String url = '${openWeatherMapUrl}?lat=${location.latitude}&lon=${location
          .longitude}&appid=$apiKey&units=metric';
      print(url);
      NetworkHelper networkHelper = NetworkHelper(url);
      var weatherData = await networkHelper.getData();
      return weatherData;
    } else {
      return null; // WE WAS WAITING A NULL IN updateUI
    }
  }
}
