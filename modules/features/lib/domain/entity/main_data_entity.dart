import 'package:dependencies/dependencies.dart';

class MainDataEntity extends Equatable {
  final String? temp;
  final double? feelsLike;
  final String? tempMin;
  final String? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

 const MainDataEntity(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel});


  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, pressure, humidity, seaLevel, grndLevel];
}
