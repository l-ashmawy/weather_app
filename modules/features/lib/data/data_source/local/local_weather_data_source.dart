import 'package:core/networking/failure.dart';
import 'package:dartz/dartz.dart' ;

import '../../models/weather_response.dart';

abstract class LocalWeatherDataSource {

  Future<void> saveWeather({required String cityName,required WeatherResponse weatherResponse});

  Future<Either<Failure,WeatherResponse>> fetchWeather(
      {required String cityName});
}
