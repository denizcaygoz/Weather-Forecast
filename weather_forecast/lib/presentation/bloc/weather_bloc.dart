import '../../domain/usecases/get_current_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  //setting the initial state to WeatherEmpty which is an empty state.
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(
            WeatherLoading()); //setting the state to loading. when user gives a new city name.
        final result = await _getCurrentWeatherUseCase.execute(
            event.cityName); //result is type Either<Failure, WeatherEntity>
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

/* Creates an [EventTransformer] that debounces events by the specified [duration].
/// This transformer will wait for a pause in events of [duration] length before
/// processing the most recent event. This is useful for:
/// - Preventing rapid-fire API calls from search inputs
/// - Reducing unnecessary processing of frequent events
/// - Handling user input that triggers network requests
/// );
*/
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
