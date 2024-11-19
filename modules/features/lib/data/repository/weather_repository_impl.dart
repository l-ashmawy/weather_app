import 'package:core/networking/failure.dart';
import 'package:dependencies/dependencies.dart';

import 'package:features/data/data_source/remote_weather_data_source_impl.dart';

import 'package:features/domain/repository/weather_repository.dart';

import '../../domain/entity/weather_entity.dart';
import '../mapper/weather_mapper.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherDataSourceImpl _dataSource;

  WeatherRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, WeatherEntity>> fetchWeather(
      {required String cityName}) async {
    var res = await _dataSource.fetchWeather(cityName: cityName);
    return res.fold(
      (l) => Left(l),
      (r) => Right(
        r.toDomainEntity(),
      ),
    );
  }
}
