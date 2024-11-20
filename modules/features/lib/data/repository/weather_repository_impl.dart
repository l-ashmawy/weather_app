import 'package:core/core.dart';
import 'package:features/data/data_source/local/local_weather_data_source.dart';

import 'package:features/domain/repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entity/weather_entity.dart';
import '../data_source/remote/remote_weather_data_source.dart';
import '../mapper/weather_mapper.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherDataSource _remoteDataSource;
  final LocalWeatherDataSource _localDataSource;
  final CheckNetworkService _checkNetworkService ;

  WeatherRepositoryImpl(this._remoteDataSource, this._localDataSource,this._checkNetworkService);

  @override
  Future<Either<Failure, WeatherEntity>> fetchWeather(
      {required String cityName}) async {
    if (!await _checkNetworkService.checkNetworkService()) {
      final localWeather =
      await _localDataSource.fetchWeather(cityName: cityName);
      return localWeather.fold(
            (l) => Left(l),
            (weather) => Right(
          weather.toDomainEntity(),
        ),
      );
    }
    var res = await _remoteDataSource.fetchWeather(cityName: cityName);
    if (!res.isRequestSuccess) {
      return Left(Failure(res.errorMessage));
    } else {
      _localDataSource.saveWeather(
          cityName: cityName, weatherResponse: res.body);
      final localWeather =
          await _localDataSource.fetchWeather(cityName: cityName);
      return localWeather.fold(
        (l) => Left(l),
        (weather) => Right(
          weather.toDomainEntity(),
        ),
      );
    }
  }
}
