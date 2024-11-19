import '../../domain/entity/wind_entity.dart';
import '../models/wind_model.dart';

extension WindMapper on WindModel {
  WindEntity toDomainEntity() {
    return WindEntity(
      speed: speed,
      deg: deg,
    );
  }
}
