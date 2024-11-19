
import '../../domain/entity/main_data_entity.dart';
import '../models/main_data_model.dart';

extension MainDataMapper on MainDataModel {
  MainDataEntity toDomainEntity() {
    return MainDataEntity(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
      humidity: humidity,
    );
  }
}
