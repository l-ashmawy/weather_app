import 'package:dependencies/dependencies.dart';

class WeatherDataEntity extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherDataEntity({this.id, this.main, this.description, this.icon});

  @override
  List<Object?> get props => [id, main, description, icon];
}
