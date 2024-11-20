import 'package:dependencies/dependencies.dart';

class GetCurrentLocationCityNameUseCase {
  Future<String> execute() async {
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placeMarks.isNotEmpty) {
      return placeMarks.first.locality!;
    }
    throw Exception("City name not found");
  }
}
