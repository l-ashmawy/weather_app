import 'package:features/data/mapper/clouds_mapper.dart';
import 'package:features/data/mapper/main_data_mapper.dart';
import 'package:features/data/mapper/sys_mapper.dart';
import 'package:features/data/mapper/weather_data_mapper.dart';
import 'package:features/data/mapper/wind_mapper.dart';
import 'package:features/data/models/weather_response.dart';
import 'package:features/domain/entity/weather_entity.dart';

extension WeatherMapper on WeatherResponse {
  WeatherEntity toDomainEntity() {
    return WeatherEntity(
      weather: weather!.map((e) => e.toDomainEntity()).toList(),
      main: main!.toDomainEntity(),
      visibility: visibility,
      wind: wind!.toDomainEntity(),
      clouds: clouds!.toDomainEntity(),
      dt: dt,
      sys: sys!.toDomainEntity(),
      timezone: timezone,
      id: id,
      name: name,
      cod: cod,
    );
  }
}
