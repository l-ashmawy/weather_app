import 'package:dependencies/dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/init_mocks.mocks.dart';


void main() {
  late MockCheckLocationPermissionUseCase useCase;

  setUp(() {
    useCase = MockCheckLocationPermissionUseCase();
  });

  group('CheckLocationPermissionUseCase', () {
    test('should return true if permission is already granted', () async {
      // Arrange
      when(Geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, true);
      verify(Geolocator.checkPermission()).called(1);
    });

    test('should return true if permission is granted after requesting', () async {
      // Arrange
      when(Geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(Geolocator.requestPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, true);
      verify(Geolocator.checkPermission()).called(1);
      verify(Geolocator.requestPermission()).called(1);
    });

    test('should return false if permission is denied after requesting', () async {
      // Arrange
      when(Geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(Geolocator.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, false);
      verify(Geolocator.checkPermission()).called(1);
      verify(Geolocator.requestPermission()).called(1);
    });

    test('should return false if permission is permanently denied', () async {
      // Arrange
      when(Geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, false);
      verify(Geolocator.checkPermission()).called(1);
    });
  });
}