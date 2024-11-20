import 'package:core/networking/failure.dart';
import 'package:features/domain/entity/clouds_entity.dart';
import 'package:features/domain/entity/main_data_entity.dart';
import 'package:features/domain/entity/sys_entity.dart';
import 'package:features/domain/entity/weather_data_entity.dart';
import 'package:features/domain/entity/wind_entity.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:features/domain/entity/weather_entity.dart';


import '../helpers/init_mocks.mocks.dart';


void main() {
  late WeatherBloc bloc;
  late MockFetchWeatherUseCase mockFetchWeatherUseCase;
  late MockCheckLocationPermissionUseCase mockCheckLocationPermissionUseCase;
  late MockGetCurrentLocationCityNameUseCase mockGetCurrentLocationCityNameUseCase;

  setUp(() {
    mockFetchWeatherUseCase = MockFetchWeatherUseCase();
    mockCheckLocationPermissionUseCase = MockCheckLocationPermissionUseCase();
    mockGetCurrentLocationCityNameUseCase = MockGetCurrentLocationCityNameUseCase();

    bloc = WeatherBloc(
      mockFetchWeatherUseCase,
      mockCheckLocationPermissionUseCase,
      mockGetCurrentLocationCityNameUseCase,
    );
  });
  WeatherEntity weatherEntity = const WeatherEntity(
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

  group('FetchWeatherWithCityNameEvent', () {
    const cityName = 'Mansoura';

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoadingState, WeatherSuccessState] when FetchWeatherWithCityNameEvent is added and use case returns success',
      build: () {
        when(mockFetchWeatherUseCase.execute(cityName: cityName))
            .thenAnswer((_) async => Right(weatherEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWeatherWithCityNameEvent(cityName: cityName)),
      expect: () => [
        WeatherLoadingState(),
        WeatherSuccessState(weather: weatherEntity, cityName: cityName),
      ],
      verify: (_) {
        verify(mockFetchWeatherUseCase.execute(cityName: cityName)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoadingState, WeatherErrorState] when FetchWeatherWithCityNameEvent is added and use case returns failure',
      build: () {
        when(mockFetchWeatherUseCase.execute(cityName: cityName))
            .thenAnswer((_) async => const Left(Failure('Error fetching weather')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWeatherWithCityNameEvent(cityName: cityName)),
      expect: () => [
        WeatherLoadingState(),
        WeatherErrorState(errorMessage: 'Error fetching weather'),
      ],
    );
  });

  group('FetchWeatherFromCurrentLocationEvent', () {
    const cityName = 'Current City';


    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherErrorState] when location permission is not granted',
      build: () {
        when(mockCheckLocationPermissionUseCase.execute())
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWeatherFromCurrentLocationEvent()),
      expect: () => [
        WeatherErrorState(errorMessage: 'Location permission not granted'),
      ],
      verify: (_) {
        verify(mockCheckLocationPermissionUseCase.execute()).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoadingState, WeatherSuccessState] when location permission is granted and weather data is fetched successfully',
      build: () {
        when(mockCheckLocationPermissionUseCase.execute())
            .thenAnswer((_) async => true);
        when(mockGetCurrentLocationCityNameUseCase.execute())
            .thenAnswer((_) async => cityName);
        when(mockFetchWeatherUseCase.execute(cityName: cityName))
            .thenAnswer((_) async => Right(weatherEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWeatherFromCurrentLocationEvent()),
      expect: () => [
        WeatherLoadingState(),
        WeatherSuccessState(weather: weatherEntity, cityName: cityName),
      ],
      verify: (_) {
        verify(mockCheckLocationPermissionUseCase.execute()).called(1);
        verify(mockGetCurrentLocationCityNameUseCase.execute()).called(1);
        verify(mockFetchWeatherUseCase.execute(cityName: cityName)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoadingState, WeatherErrorState] when location permission is granted but fetching weather fails',
      build: () {
        when(mockCheckLocationPermissionUseCase.execute())
            .thenAnswer((_) async => true);
        when(mockGetCurrentLocationCityNameUseCase.execute())
            .thenAnswer((_) async => cityName);
        when(mockFetchWeatherUseCase.execute(cityName: cityName))
            .thenAnswer((_) async => const Left(Failure('Error fetching weather')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWeatherFromCurrentLocationEvent()),
      expect: () => [
        WeatherLoadingState(),
        WeatherErrorState(errorMessage: 'Error fetching weather'),
      ],
    );
  });
}