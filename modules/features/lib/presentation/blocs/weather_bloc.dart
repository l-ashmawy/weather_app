import 'package:dependencies/dependencies.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:features/domain/use_cases/fetch_weather_use_case.dart';

import '../../domain/use_cases/check_location_permission_use_case.dart';
import '../../domain/use_cases/get_current_location_city_name_use_case.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;
  final CheckLocationPermissionUseCase checkLocationPermissionUseCase;

  final GetCurrentLocationCityNameUseCase getCurrentLocationCityNameUseCase;

  WeatherBloc(
    this.fetchWeatherUseCase,
    this.checkLocationPermissionUseCase,
    this.getCurrentLocationCityNameUseCase,
  ) : super(WeatherInitial()) {
    on<FetchWeatherWithCityNameEvent>(_fetchWeatherWithCityNameEvent);
    on<FetchWeatherFromCurrentLocationEvent>(
        _fetchWeatherFromCurrentLocationEvent);
  }

  void _fetchWeatherFromCurrentLocationEvent(
      FetchWeatherFromCurrentLocationEvent event,
      Emitter<WeatherState> emit) async {
    final isPermissionGranted = await checkLocationPermissionUseCase.execute();
    if (isPermissionGranted) {
      final cityName = await getCurrentLocationCityNameUseCase.execute();
      add(FetchWeatherWithCityNameEvent(cityName: cityName));
    } else {
      emit(WeatherErrorState(errorMessage: "Location permission not granted"));
    }
  }

  void _fetchWeatherWithCityNameEvent(
      FetchWeatherWithCityNameEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());

    final result = await fetchWeatherUseCase.execute(cityName: event.cityName);
    result.fold(
      (failure) => emit(WeatherErrorState(errorMessage: failure.message)),
      (weather) => emit(WeatherSuccessState(weather: weather)),
    );
  }
}
