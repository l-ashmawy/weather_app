import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc() : super(SplashAnimationStarted()) {
    Future.delayed(const Duration(seconds: 2), () {
      add(const OnAnimationEnded());
    });
    on<OnAnimationEnded>(
      (event, emit) async {
        Modular.to.navigate(NavigatorKeys.FEATURES_KEY + NavigatorKeys.WEATHER_PAGE);
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
