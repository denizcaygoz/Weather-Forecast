import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/data/models/weather_model.dart';
import 'package:weather_forecast/domain/entities/weather.dart';
import '../../helpers/json_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    cityName: 'Zocca',
    currentTemp: 23.61, // 296.76K - 273.15
    weatherIcon: '10d',
    tempMax: 24.72, // 297.87K - 273.15
    tempMin: 21.61, // 294.76K - 273.15
    hourlyForecasts: [
      HourlyForecast(
        time: DateTime.parse("2022-08-30 15:00:00"),
        temp: 23.61,
        weatherIcon: "10d",
      ),
      HourlyForecast(
        time: DateTime.parse("2022-08-30 18:00:00"),
        temp: 22.3,
        weatherIcon: "10n",
      ),
    ],
    dailyForecasts: [
      DailyForecast(
        date: DateTime.parse("2022-08-30 15:00:00"),
        temp: 23.61,
        weatherIcon: "10d",
        dayOfWeek: "Tue",
      ),
    ],
    sunrise: DateTime.fromMillisecondsSinceEpoch(1661834187 * 1000),
    sunset: DateTime.fromMillisecondsSinceEpoch(1661882248 * 1000),
    windSpeed: 0.62,
    windDegree: 349,
    windGust: 1.18,
    humidity: 69,
    feelsLike: 23.83, // 296.98K - 273.15
  );

  group('WeatherModel', () {
    test('should be a subclass of WeatherEntity', () {
      expect(tWeatherModel, isA<WeatherEntity>());
    });

    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result.cityName, tWeatherModel.cityName);
      expect(result.currentTemp.toStringAsFixed(2),
          tWeatherModel.currentTemp.toStringAsFixed(2));
      expect(result.weatherIcon, tWeatherModel.weatherIcon);
      expect(result.windSpeed, tWeatherModel.windSpeed);
      expect(result.windDegree, tWeatherModel.windDegree);
      expect(result.windGust, tWeatherModel.windGust);
      expect(result.humidity, tWeatherModel.humidity);

      // Test hourly forecasts
      expect(result.hourlyForecasts.length, 2);
      expect(result.hourlyForecasts[0].time,
          DateTime.parse("2022-08-30 15:00:00"));
      expect(result.hourlyForecasts[0].temp.toStringAsFixed(2), "23.61");
      expect(result.hourlyForecasts[0].weatherIcon, "10d");

      // Test daily forecasts
      expect(result.dailyForecasts.length, 1);
      expect(
          result.dailyForecasts[0].date, DateTime.parse("2022-08-30 15:00:00"));
      expect(result.dailyForecasts[0].temp.toStringAsFixed(2), "23.61");
      expect(result.dailyForecasts[0].weatherIcon, "10d");
      expect(result.dailyForecasts[0].dayOfWeek, "Tue");
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'list': [
          {
            'main': {
              'temp': 296.76,
              'temp_max': 297.87,
              'temp_min': 294.76,
              'feels_like': 296.98,
              'humidity': 69,
            },
            'weather': [
              {
                'icon': '10d',
              }
            ],
            'wind': {
              'speed': 0.62,
              'deg': 349,
              'gust': 1.18,
            },
          }
        ],
        'city': {
          'name': 'Zocca',
          'sunrise': 1661834187,
          'sunset': 1661882248,
        },
      };

      expect(
          (result as Map<String, dynamic>)['list']![0]['main']!['feels_like']
              .toStringAsFixed(2),
          (expectedJsonMap['list']! as List)[0]['main']!['feels_like']
              .toStringAsFixed(2));
      expect((result as Map<String, dynamic>)['city'], expectedJsonMap['city']);
    });
  });
}
