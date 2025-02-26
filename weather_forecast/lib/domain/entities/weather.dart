import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final double currentTemp;
  final String weatherIcon;
  final double tempMax;
  final double tempMin;
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;
  final String cityName;
  final DateTime sunrise;
  final DateTime sunset;
  final double windSpeed;
  final int windDegree;
  final double windGust;
  final int humidity;
  final double feelsLike;

  const WeatherEntity({
    required this.currentTemp,
    required this.weatherIcon,
    required this.tempMax,
    required this.tempMin,
    required this.hourlyForecasts,
    required this.dailyForecasts,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.windDegree,
    required this.windGust,
    required this.humidity,
    required this.feelsLike,
  });

  @override
  List<Object?> get props => [
        currentTemp,
        weatherIcon,
        tempMax,
        tempMin,
        hourlyForecasts,
        dailyForecasts,
        cityName,
        sunrise,
        sunset,
        windSpeed,
        windDegree,
        windGust,
        humidity,
        feelsLike,
      ];
}

class HourlyForecast extends Equatable {
  final DateTime time;
  final double temp;
  final String weatherIcon;

  const HourlyForecast({
    required this.time,
    required this.temp,
    required this.weatherIcon,
  });

  @override
  List<Object?> get props => [time, temp, weatherIcon];
}

class DailyForecast extends Equatable {
  final DateTime date;
  final double temp;
  final String weatherIcon;
  final String dayOfWeek;

  const DailyForecast({
    required this.date,
    required this.temp,
    required this.weatherIcon,
    required this.dayOfWeek,
  });

  @override
  List<Object?> get props => [date, temp, weatherIcon, dayOfWeek];
}
