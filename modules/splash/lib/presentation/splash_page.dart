import 'package:art_core/art_core.dart';
import 'package:art_core/resources/assets_manager.dart';
import 'package:dependencies/dependencies.dart';
import 'package:splash/presentation/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<SplashBloc, SplashState>(
      bloc: Modular.get<SplashBloc>(),
      builder: (context, state) {
        return const AnimatedComponent(
          path :AssetsManager.splashIcon,
          width: 180,
          height: 180,
        );
      },
    ));
  }
}
