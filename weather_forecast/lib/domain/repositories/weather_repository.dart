import 'package:dartz/dartz.dart';
import '../entities/weather.dart';
import '../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
