import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:features/domain/entity/clouds_entity.dart';
import 'package:features/domain/entity/main_data_entity.dart';
import 'package:features/domain/entity/sys_entity.dart';
import 'package:features/domain/entity/weather_data_entity.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:features/domain/entity/wind_entity.dart';
import 'package:features/domain/use_cases/fetch_weather_use_case.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/init_mocks.mocks.dart';

void main() {
  late MockWeatherRepositoryImpl repository;
  late FetchWeatherUseCase useCase;

  setUp(() {
    repository = MockWeatherRepositoryImpl();
    useCase = FetchWeatherUseCase(repository);
  });
  const cityName = 'Mansoura';

  WeatherEntity mockWeatherEntity = const WeatherEntity(
    weather: [
      WeatherDataEntity(
        id: 1,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
      ),
    ],
    main: MainDataEntity(
        temp: "20 \u00B0C",
        tempMin: "16 \u00B0C",
        tempMax: "24 \u00B0C",
        pressure: 1013,
        humidity: 82,
        grndLevel: 20,
        seaLevel: 10),
    visibility: 10000,
    wind: WindEntity(
      speed: 3.5,
      deg: 200,
    ),
    clouds: CloudsEntity(
      all: 20,
    ),
    dt: 1633035600,
    sys: SysEntity(
      type: 1,
      id: 8074,
      country: 'US',
      sunrise: 1633005600,
      sunset: 1633048800,
    ),
    timezone: -14400,
    id: 5128581,
    name: 'New York',
  );


  test('should get list of movies from the repository', () async {
    // arrange
    when(repository.fetchWeather(cityName: cityName))
        .thenAnswer((_) async => right(mockWeatherEntity));
    // act
    final result = await useCase.execute(cityName: cityName);
    // assert
    expect(result, Right(mockWeatherEntity));
    verify(repository.fetchWeather(cityName: cityName));
    verifyNoMoreInteractions(repository);
  });

  test('should get Error from the repository', () async {
    // arrange
    when(repository.fetchWeather(cityName: cityName))
        .thenAnswer((_) async => left(const Failure("Server Error")));
    // act
    final result = await useCase.execute(cityName: cityName);
    // assert
    expect(result, const Left(Failure("Server Error")));
    verify(repository.fetchWeather(cityName: cityName));
    verifyNoMoreInteractions(repository);
  });
}
