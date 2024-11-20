import 'package:core/router/navigator_keys.dart';
import 'package:features/data/repository/weather_repository_impl.dart';
import 'package:features/domain/use_cases/fetch_weather_use_case.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';
import 'package:features/presentation/pages/weather_page.dart';
import 'package:dependencies/dependencies.dart';

import 'data/data_source/local/local_weather_data_source_impl.dart';
import 'data/data_source/remote/remote_weather_data_source_impl.dart';
import 'domain/use_cases/check_location_permission_use_case.dart';
import 'domain/use_cases/get_current_location_city_name_use_case.dart';

class FeaturesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => RemoteWeatherDataSourceImpl(i())),
        Bind.lazySingleton((i) => LocalWeatherDataSourceImpl(cacheManager: i())),
        Bind.lazySingleton((i) => WeatherRepositoryImpl(i(),i(),i())),
        Bind.lazySingleton((i) => FetchWeatherUseCase(i())),
        Bind.lazySingleton((i) => GetCurrentLocationCityNameUseCase()),
        Bind.lazySingleton((i) => CheckLocationPermissionUseCase()),
        Bind.factory((i) => WeatherBloc(i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(NavigatorKeys.WEATHER_PAGE,
            child: (_, args) => const WeatherPage()),
      ];
}
