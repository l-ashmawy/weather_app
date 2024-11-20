import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/features_module.dart';
import 'package:splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<DioClient>((i) => DioClient(ApiConfigurations())),
    Bind.lazySingleton<Dio>((i) => i<DioClient>().dio),
    Bind.lazySingleton<NetworkHandler>((i) => NetworkHandler(i())),
    Bind.lazySingleton<CacheManager>((i) => CacheManagerImpl()),
    Bind.lazySingleton<CheckNetworkService>((i) => CheckNetworkService()),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(NavigatorKeys.SPLASH_KEY, module: SplashModule()),
        ModuleRoute(NavigatorKeys.FEATURES_KEY, module: FeaturesModule()),
      ];

  @override
  List<Module> get imports => [
        SplashModule(),
        FeaturesModule(),
      ];
}
