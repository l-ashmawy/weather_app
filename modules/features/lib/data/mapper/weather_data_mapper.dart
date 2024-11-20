import 'package:core/core.dart';
import 'package:features/data/models/weather_data_model.dart';
import 'package:features/domain/entity/weather_data_entity.dart';

extension WeatherDataMapper on WeatherDataModel {
  WeatherDataEntity toDomainEntity() {
    return WeatherDataEntity(
      id: id,
      main: main,
      description: description,
      icon: "${ApiConfigurations().imageBaseUrl}$icon@2x.png",
    );
  }
}
