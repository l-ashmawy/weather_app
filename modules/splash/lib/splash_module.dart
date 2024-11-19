import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:splash/presentation/splash_bloc.dart';
import 'package:splash/presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  void binds(i) {
    /// DATA SOURCE REMOTE && LOCAL

    /// UES CASES
    i.addLazySingleton(SplashBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(NavigatorKeys.SPLASH_KEY, child: (context) => const SplashPage());
  }
}
