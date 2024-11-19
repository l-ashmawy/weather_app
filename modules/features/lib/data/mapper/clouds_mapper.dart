import 'package:features/domain/entity/clouds_entity.dart';

import '../models/clouds_model.dart';

extension CloudsMapper on CloudsModel {
  CloudsEntity toDomainEntity() {
    return CloudsEntity(all: all);
  }
}
