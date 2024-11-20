import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:splash/presentation/splash_bloc.dart';
import 'package:splash/presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => SplashBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(NavigatorKeys.SPLASH_KEY,
            child: (_, args) => const SplashPage()),
      ];
}
