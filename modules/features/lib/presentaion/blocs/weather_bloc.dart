import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:features/domain/use_cases/fetch_weather_use_case.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;

  WeatherBloc(this.fetchWeatherUseCase) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  void _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());

    final result = await fetchWeatherUseCase.execute(cityName: event.cityName);

    result.fold(
      (failure) => emit(WeatherErrorState(errorMessage: failure.message)),
      (weather) => emit(WeatherSuccessState(weather: weather)),
    );
  }
}
