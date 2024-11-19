import 'package:core/networking/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/weather_response.dart';

abstract class RemoteWeatherDataSource {
  Future<Either<Failure, WeatherResponse>> fetchWeather(
      {required String cityName});
}
