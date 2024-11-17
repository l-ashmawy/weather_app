import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PreferenceManager preferenceManager = Modular.get<PreferenceManager>();

  SplashBloc() : super(SplashAnimationStarted()) {
    Future.delayed(const Duration(seconds: 2), () {
      add(const OnAnimationEnded());
    });
    on<OnAnimationEnded>(
      (event, emit) async {
        // Modular.to.navigate(NavigatorKeys.AUTH_KEY + NavigatorKeys.ENTER_EMAIL);
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
