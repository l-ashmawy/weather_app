part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherSuccessState extends WeatherState {
  final WeatherEntity weather;
  final String cityName ;

  WeatherSuccessState({required this.weather, required this.cityName});

  @override
  List<Object?> get props => [weather];
}

class WeatherErrorState extends WeatherState {
  final String errorMessage;

  WeatherErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
