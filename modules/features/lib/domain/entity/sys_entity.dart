import 'package:dependencies/dependencies.dart';

class SysEntity extends Equatable {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const SysEntity(
      {this.type, this.id, this.country, this.sunrise, this.sunset});

  @override
  List<Object?> get props => [type, id, country, sunrise, sunset];
}
