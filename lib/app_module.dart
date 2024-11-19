import 'package:core/cache/preference_manager.dart';
import 'package:core/core.dart';
import 'package:core/networking/dio_client.dart';
import 'package:dependencies/dependencies.dart';
import 'package:splash/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(PreferenceManager.new);
    i.addLazySingleton<DioClient>((i) => DioClient());
    i.addLazySingleton<Dio>((i) => i<DioClient>().dio);
  }

  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.module(NavigatorKeys.SPLASH_KEY, module: SplashModule());
  }
}
