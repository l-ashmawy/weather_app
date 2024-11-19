import 'package:dependencies/dependencies.dart';

class WindEntity extends Equatable{
  final double? speed;
  final int? deg;

  const WindEntity({this.speed, this.deg});

  @override
  List<Object?> get props => [speed, deg];


}
