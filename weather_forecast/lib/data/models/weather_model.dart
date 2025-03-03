import 'package:weather_forecast/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required double currentTemp,
    required String weatherIcon,
    required double tempMax,
    required double tempMin,
    required List<HourlyForecast> hourlyForecasts,
    required List<DailyForecast> dailyForecasts,
    required String cityName,
    required DateTime sunrise,
    required DateTime sunset,
    required double windSpeed,
    required int windDegree,
    required double windGust,
    required int humidity,
    required double feelsLike,
    required String main,
    required String description,
  }) : super(
          currentTemp: currentTemp,
          weatherIcon: weatherIcon,
          tempMax: tempMax,
          tempMin: tempMin,
          hourlyForecasts: hourlyForecasts,
          dailyForecasts: dailyForecasts,
          cityName: cityName,
          sunrise: sunrise,
          sunset: sunset,
          windSpeed: windSpeed,
          windDegree: windDegree,
          windGust: windGust,
          humidity: humidity,
          feelsLike: feelsLike,
          main: main,
          description: description,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final firstWeather = json['list'][0];
    final city = json['city'];

    return WeatherModel(
      currentTemp: _kelvinToCelsius(firstWeather['main']['temp']),
      weatherIcon: firstWeather['weather'][0]['icon'],
      tempMax: _kelvinToCelsius(firstWeather['main']['temp_max']),
      tempMin: _kelvinToCelsius(firstWeather['main']['temp_min']),
      hourlyForecasts: (json['list'] as List)
          .take(8)
          .map((item) => HourlyForecast(
                time: DateTime.parse(item['dt_txt']),
                temp: _kelvinToCelsius(item['main']['temp']),
                weatherIcon: item['weather'][0]['icon'],
              ))
          .toList(),
      dailyForecasts: _createDailyForecasts(json['list'] as List),
      cityName: city['name'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(city['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(city['sunset'] * 1000),
      windSpeed: firstWeather['wind']['speed'].toDouble(),
      windDegree: firstWeather['wind']['deg'],
      windGust: firstWeather['wind']['gust']?.toDouble() ?? 0.0,
      humidity: firstWeather['main']['humidity'],
      feelsLike: _kelvinToCelsius(firstWeather['main']['feels_like']),
      main: firstWeather['weather'][0]['main'],
      description: firstWeather['weather'][0]['description'],
    );
  }

  static double _kelvinToCelsius(dynamic kelvin) {
    return (kelvin - 273.15).toDouble();
  }

  static double _celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  static List<DailyForecast> _createDailyForecasts(List<dynamic> list) {
    final dailyForecasts = <DailyForecast>[];

    for (var item in list) {
      final date = DateTime.parse(item['dt_txt']);
      if (date.hour == 15) {
        dailyForecasts.add(DailyForecast(
          date: date,
          temp: _kelvinToCelsius(item['main']['temp']),
          weatherIcon: item['weather'][0]['icon'],
          dayOfWeek: _getDayOfWeek(date.weekday),
        ));
      }
    }

    return dailyForecasts;
  }

  static String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  WeatherEntity toEntity() => WeatherEntity(
        currentTemp: currentTemp,
        weatherIcon: weatherIcon,
        tempMax: tempMax,
        tempMin: tempMin,
        hourlyForecasts: hourlyForecasts,
        dailyForecasts: dailyForecasts,
        cityName: cityName,
        sunrise: sunrise,
        sunset: sunset,
        windSpeed: windSpeed,
        windDegree: windDegree,
        windGust: windGust,
        humidity: humidity,
        feelsLike: feelsLike,
        main: main,
        description: description,
      );

  Map<String, dynamic> toJson() => {
        'list': [
          {
            'main': {
              'temp': _celsiusToKelvin(currentTemp),
              'temp_max': _celsiusToKelvin(tempMax),
              'temp_min': _celsiusToKelvin(tempMin),
              'feels_like': _celsiusToKelvin(feelsLike),
              'humidity': humidity,
            },
            'weather': [
              {
                'icon': weatherIcon,
              }
            ],
            'wind': {
              'speed': windSpeed,
              'deg': windDegree,
              'gust': windGust,
            },
          }
        ],
        'city': {
          'name': cityName,
          'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
          'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
        },
      };
}
