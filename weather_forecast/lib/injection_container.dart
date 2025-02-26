import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:weather_forecast/domain/usecases/get_current_weather.dart';
import 'package:weather_forecast/presentation/bloc/weather_bloc.dart';
import 'package:weather_forecast/data/repositories/weather_repository_impl.dart';
import "package:weather_forecast/data/data_sources/remote_data_source.dart";
import "package:weather_forecast/domain/repositories/weather_repository.dart";

final locator = GetIt.instance;

void setupLocator() {
  // 1. External/Third Party
  locator.registerLazySingleton(() => http.Client());

  // 2. Data Sources
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );

  // 3. Repositories
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // 4. Use Cases
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // 5. BLoCs/ViewModels
  locator.registerFactory(() => WeatherBloc(locator()));
}
