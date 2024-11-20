part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable{}


class FetchWeatherWithCityNameEvent extends WeatherEvent {
  final String cityName;
  FetchWeatherWithCityNameEvent({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}

class FetchWeatherFromCurrentLocationEvent extends WeatherEvent {
  FetchWeatherFromCurrentLocationEvent();

  @override
  List<Object?> get props => [];
}