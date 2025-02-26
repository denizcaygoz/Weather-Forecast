import 'package:equatable/equatable.dart';
import '../../domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

//this state is used to indicate that the weather data is empty.
class WeatherEmpty extends WeatherState {}

//this state is used to indicate that the weather data is being loaded.
class WeatherLoading extends WeatherState {}

//this state is used to indicate that the weather data has been loaded.
class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

//this state is used to indicate that the weather data is failed to load.
class WeatherLoadFailue extends WeatherState {
  final String message;

  const WeatherLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
