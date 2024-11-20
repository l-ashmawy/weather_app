import 'package:core/core.dart';
import 'package:features/data/models/clouds_model.dart';
import 'package:features/data/models/main_data_model.dart';
import 'package:features/data/models/sys_model.dart';
import 'package:features/data/models/weather_data_model.dart';
import 'package:features/data/models/weather_response.dart';
import 'package:features/data/models/wind_model.dart';
import 'package:features/data/repository/weather_repository_impl.dart';
import 'package:features/domain/entity/clouds_entity.dart';
import 'package:features/domain/entity/main_data_entity.dart';
import 'package:features/domain/entity/sys_entity.dart';
import 'package:features/domain/entity/weather_data_entity.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:features/domain/entity/wind_entity.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart' hide Bind;

import '../helpers/init_mocks.mocks.dart';

void main() {
  late MockRemoteWeatherDataSourceImpl remoteDataSource;
  late WeatherRepositoryImpl repository;
  late MockLocalWeatherDataSourceImpl localDataSource;
  late MockCheckNetworkService checkNetworkService;

  setUp(() {
    remoteDataSource = MockRemoteWeatherDataSourceImpl();
    localDataSource = MockLocalWeatherDataSourceImpl();
    checkNetworkService = MockCheckNetworkService();
    repository = WeatherRepositoryImpl(
        remoteDataSource, localDataSource, checkNetworkService);
  });

  WeatherResponse mockWeatherResponse = WeatherResponse(
    weather: [
      WeatherDataModel(
        id: 1,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
      ),
    ],
    main: MainDataModel(
        temp: 20.15,
        tempMin: 16.15,
        tempMax: 24.15,
        pressure: 1013,
        humidity: 82,
        grndLevel: 20,
        seaLevel: 10),
    visibility: 10000,
    wind: WindModel(
      speed: 3.5,
      deg: 200,
    ),
    clouds: CloudsModel(
      all: 20,
    ),
    dt: 1633035600,
    sys: SysModel(
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

  WeatherEntity mockWeatherEntity = const WeatherEntity(
    weather: [
      WeatherDataEntity(
        id: 1,
        main: 'Clear',
        description: 'clear sky',
        icon: 'https://openweathermap.org/img/wn/01d@2x.png',
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

  group('fetchWeather', () {
    const cityName = 'Mansoura';

    test('should fetch weather from local data source when offline', () async {
      when(checkNetworkService.checkNetworkService())
          .thenAnswer((_) async => false);
      when(localDataSource.fetchWeather(cityName: cityName))
          .thenAnswer((_) async => Right(mockWeatherResponse));

      final result = await repository.fetchWeather(cityName: cityName);

      expect(result, Right(mockWeatherEntity));
      verify(checkNetworkService.checkNetworkService()).called(1);
      verify(localDataSource.fetchWeather(cityName: cityName)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should fetch weather from remote and save to local when online',
            () async {
          final mockResponse = NetworkResponse(
            mockWeatherResponse,
            true,
            '',
          );

          when(checkNetworkService.checkNetworkService())
              .thenAnswer((_) async => true);
          when(remoteDataSource.fetchWeather(cityName: cityName))
              .thenAnswer((_) async => mockResponse);
          when(localDataSource.fetchWeather(cityName: cityName))
              .thenAnswer((_) async => Right(mockWeatherResponse));
          when(localDataSource.saveWeather(
            cityName: cityName,
            weatherResponse: mockWeatherResponse,
          )).thenAnswer((_) async {});

          final result = await repository.fetchWeather(cityName: cityName);

          expect(result, Right(mockWeatherEntity));
          verify(checkNetworkService.checkNetworkService()).called(1);
          verify(remoteDataSource.fetchWeather(cityName: cityName)).called(1);
          verify(localDataSource.saveWeather(
            cityName: cityName,
            weatherResponse: mockWeatherResponse,
          )).called(1);
        });

    test('should return Failure when remote fetch fails', () async {
      final mockErrorResponse =
      NetworkResponse(mockWeatherResponse, false, "server error");

      when(checkNetworkService.checkNetworkService())
          .thenAnswer((_) async => true);
      when(remoteDataSource.fetchWeather(cityName: cityName))
          .thenAnswer((_) async => mockErrorResponse);

      final result = await repository.fetchWeather(cityName: cityName);

      expect(result, const Left(Failure('server error')));
      verify(checkNetworkService.checkNetworkService()).called(1);
      verify(remoteDataSource.fetchWeather(cityName: cityName)).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}