import 'package:dependencies/dependencies.dart';
import 'package:features/domain/entity/main_data_entity.dart';
import 'package:features/domain/entity/sys_entity.dart';
import 'package:features/domain/entity/weather_data_entity.dart';
import 'package:features/domain/entity/wind_entity.dart';

import 'clouds_entity.dart';

class WeatherEntity extends Equatable {
  final List<WeatherDataEntity>? weather;
  final MainDataEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const WeatherEntity(
      {this.weather,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  @override
  List<Object?> get props => [
        weather,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod
      ];
}
