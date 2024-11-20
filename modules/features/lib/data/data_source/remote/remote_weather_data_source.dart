import 'package:core/core.dart';

import '../../models/weather_response.dart';

abstract class RemoteWeatherDataSource {
  Future<NetworkResponse<WeatherResponse>> fetchWeather(
      {required String cityName});
}
