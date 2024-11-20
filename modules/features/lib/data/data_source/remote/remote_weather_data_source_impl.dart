import 'package:core/core.dart';
import 'package:flutter/services.dart';

import 'remote_weather_data_source.dart';
import '../../models/weather_response.dart';

class RemoteWeatherDataSourceImpl implements RemoteWeatherDataSource {
  final NetworkHandler _networkHandler;

  RemoteWeatherDataSourceImpl(this._networkHandler);

  @override
  Future<NetworkResponse<WeatherResponse>> fetchWeather(
      {required String cityName}) async {
    final envVars = await loadEnvFile();

    final appId = envVars['appid'];

    return await _networkHandler.get<WeatherResponse>(
      WeatherResponse(),
      "?q=$cityName&appid=$appId&units=metric",
    );
  }

  Future<Map<String, String>> loadEnvFile() async {
    String envContent = await rootBundle.loadString('.env');
    return _parseEnv(envContent);
  }

  Map<String, String> _parseEnv(String content) {
    final Map<String, String> envVars = {};
    final lines = content.split('\n');

    for (var line in lines) {
      // Ignore empty lines and comments
      if (line.isNotEmpty && !line.startsWith('#')) {
        final keyValue = line.split('=');
        if (keyValue.length == 2) {
          envVars[keyValue[0].trim()] = keyValue[1].trim();
        }
      }
    }
    return envVars;
  }
}
