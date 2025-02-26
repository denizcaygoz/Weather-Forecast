import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_forecast/data/data_sources/remote_data_source.dart';
import 'package:weather_forecast/domain/repositories/weather_repository.dart';
import 'package:weather_forecast/domain/usecases/get_current_weather.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
  GetCurrentWeatherUseCase,
  http.Client,
])
void main() {}
