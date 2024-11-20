import 'package:core/networking/failure.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:dartz/dartz.dart' ;

abstract class WeatherRepository {

  Future<Either<Failure , WeatherEntity>> fetchWeather(
      {required String cityName});

}
