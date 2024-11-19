part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable{}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;

  FetchWeatherEvent({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
