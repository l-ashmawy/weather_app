import 'package:core/core.dart';
import 'package:features/presentaion/blocs/weather_bloc.dart';
import 'package:features/presentaion/pages/weather_page.dart';

import 'data/data_source/remote_weather_data_source_impl.dart';
import 'data/repository/weather_repository_impl.dart';
import 'data/data_source/remote_weather_data_source.dart';
import 'domain/repository/weather_repository.dart';
import 'domain/use_cases/fetch_weather_use_case.dart';

class FeaturesModule extends Module {
  @override
  void binds(i) {
    /// DATA SOURCE REMOTE && LOCAL
    i.addLazySingleton<RemoteWeatherDataSource>(RemoteWeatherDataSourceImpl.new);

    /// REPOSITORIES
    i.addLazySingleton<WeatherRepository>(WeatherRepositoryImpl.new);

    /// UES CASES
    i.addLazySingleton(FetchWeatherUseCase.new);

    /// CONTROLLERS
    i.addLazySingleton(WeatherBloc.new);

  }

  @override
  void routes(RouteManager r) {
    r.child(NavigatorKeys.WEATHER_PAGE, child: (context) => const WeatherPage());

  }

}
