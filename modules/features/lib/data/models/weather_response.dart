import 'package:core/core.dart';
import 'package:features/data/models/sys_model.dart';
import 'package:features/data/models/weather_data_model.dart';
import 'package:features/data/models/wind_model.dart';

import 'clouds_model.dart';
import 'main_data_model.dart';

class WeatherResponse extends BaseMappable {
  List<WeatherDataModel>? weather;
  MainDataModel? main;
  int? visibility;
  WindModel? wind;
  CloudsModel? clouds;
  int? dt;
  SysModel? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherResponse(
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
  Mappable fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <WeatherDataModel>[];
      json['weather'].forEach((v) {
        weather!.add(WeatherDataModel.fromJson(v));
      });
    }
    main = json['main'] != null ? MainDataModel.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? WindModel.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? CloudsModel.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? SysModel.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];

    return WeatherResponse(
      weather: weather,
      main: main,
      visibility: visibility,
      wind: wind,
      clouds: clouds,
      dt: dt,
      sys: sys,
      timezone: timezone,
      id: id,
      name: name,
      cod: cod,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}
