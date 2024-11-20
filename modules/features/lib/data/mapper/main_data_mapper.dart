
import '../../domain/entity/main_data_entity.dart';
import '../models/main_data_model.dart';

extension MainDataMapper on MainDataModel {
  MainDataEntity toDomainEntity() {
    return MainDataEntity(
      temp: "$temp \u00B0C",
      tempMin: "$tempMin \u00B0C",
      tempMax: "$tempMax \u00B0C",
      pressure: pressure,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
      humidity: humidity,
    );
  }
}
