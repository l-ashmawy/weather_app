import '../../domain/entity/sys_entity.dart';
import '../models/sys_model.dart';

extension SysMapper on SysModel {
  SysEntity toDomainEntity() {
    return SysEntity(
      type: type,
      id: id,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
