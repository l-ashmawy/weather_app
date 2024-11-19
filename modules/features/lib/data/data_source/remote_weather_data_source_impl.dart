import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'remote_weather_data_source.dart';
import '../models/weather_response.dart';

class RemoteWeatherDataSourceImpl implements RemoteWeatherDataSource {
  final NetworkHandler _networkHandler;

  RemoteWeatherDataSourceImpl(this._networkHandler);

  @override
  Future<Either<Failure, WeatherResponse>> fetchWeather(
      {required String cityName}) async {
    var response = await _networkHandler.get<WeatherResponse>(
      WeatherResponse(),
      "?q=$cityName&appid=cd44a52285615a44c82b0927411feabd&units=metric",
    );

    if (response.isRequestSuccess) {
      return Right(response.body);
    } else {
      return Left(Failure(response.errorMessage));
    }
  }
}
