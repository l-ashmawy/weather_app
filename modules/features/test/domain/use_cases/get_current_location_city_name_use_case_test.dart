import 'package:dependencies/dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/init_mocks.mocks.dart';

void main() {
  late MockGetCurrentLocationCityNameUseCase useCase;

  setUp(() {
    useCase = MockGetCurrentLocationCityNameUseCase();
  });

  group('GetCurrentLocationCityNameUseCase', () {
    test('should return city name when geolocation and place mark retrieval succeed', () async {
      // Arrange
      final mockPosition = Position(
        latitude: 37.7749,
        longitude: -122.4194,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 1,
        headingAccuracy: 1,
      );

      final mockPlaceMark = Placemark(
        locality: 'San Francisco',
      );

      when(Geolocator.getCurrentPosition(locationSettings: anyNamed('locationSettings')))
          .thenAnswer((_) async => mockPosition);
      when(placemarkFromCoordinates(mockPosition.latitude, mockPosition.longitude))
          .thenAnswer((_) async => [mockPlaceMark]);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, 'San Francisco');
      verify(Geolocator.getCurrentPosition(locationSettings: anyNamed('locationSettings'))).called(1);
      verify(placemarkFromCoordinates(mockPosition.latitude, mockPosition.longitude)).called(1);
    });

    test('should throw Exception when no city name is found', () async {
      // Arrange
      final mockPosition = Position(
        latitude: 37.7749,
        longitude: -122.4194,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 1,
        headingAccuracy: 1,
      );

      when(Geolocator.getCurrentPosition(locationSettings: anyNamed('locationSettings')))
          .thenAnswer((_) async => mockPosition);
      when(placemarkFromCoordinates(mockPosition.latitude, mockPosition.longitude))
          .thenAnswer((_) async => []);

      // Act
      expect(() async => await useCase.execute(), throwsException);

      // Assert
      verify(Geolocator.getCurrentPosition(locationSettings: anyNamed('locationSettings'))).called(1);
      verify(placemarkFromCoordinates(mockPosition.latitude, mockPosition.longitude)).called(1);
    });
  });
}