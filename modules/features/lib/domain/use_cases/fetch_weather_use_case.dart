import 'package:core/networking/failure.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:dartz/dartz.dart' ;

import '../repository/weather_repository.dart';

class FetchWeatherUseCase {
  final WeatherRepository repository;

  FetchWeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> execute({required String cityName}) {

    return repository.fetchWeather(cityName: cityName);
  }
}
