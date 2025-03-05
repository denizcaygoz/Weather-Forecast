import 'package:weather_forecast/.env/keys.dart';

class Urls {
  static const String baseUrl = EnvKeys.baseUrl;
  static const String apiKey = EnvKeys.apiKey;
  static String currentWeatherByName(String city) =>
      '$baseUrl/forecast?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
