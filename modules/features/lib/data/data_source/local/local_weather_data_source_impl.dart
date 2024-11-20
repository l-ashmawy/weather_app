
import 'dart:convert';

import 'package:core/core.dart';
import 'package:features/data/models/weather_response.dart';
import 'package:dartz/dartz.dart';
import 'local_weather_data_source.dart';

class LocalWeatherDataSourceImpl implements LocalWeatherDataSource {
  final CacheManager cacheManager;

  LocalWeatherDataSourceImpl({required this.cacheManager});

  @override
  Future<Either<Failure, WeatherResponse>> fetchWeather(
      {required String cityName}) async {
    try {
      final response = await cacheManager.getValue(cityName);
      return Right(WeatherResponse().fromJson(jsonDecode(response)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> saveWeather(
      {required String cityName, required WeatherResponse weatherResponse}) async {
    return cacheManager.saveValue(cityName, jsonEncode(weatherResponse));
  }

}
