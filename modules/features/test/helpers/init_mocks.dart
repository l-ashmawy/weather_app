import 'package:core/networking/check_network_service.dart';
import 'package:features/data/data_source/local/local_weather_data_source_impl.dart';
import 'package:features/data/data_source/remote/remote_weather_data_source_impl.dart';
import 'package:features/data/repository/weather_repository_impl.dart';
import 'package:features/domain/use_cases/check_location_permission_use_case.dart';
import 'package:features/domain/use_cases/fetch_weather_use_case.dart';
import 'package:features/domain/use_cases/get_current_location_city_name_use_case.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  RemoteWeatherDataSourceImpl,
  LocalWeatherDataSourceImpl,
  WeatherRepositoryImpl,
  FetchWeatherUseCase,
  CheckLocationPermissionUseCase,
  GetCurrentLocationCityNameUseCase,
  CheckNetworkService,
  WeatherBloc,
], customMocks: [])
void main() {}
