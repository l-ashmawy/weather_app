part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class OnAnimationEnded extends SplashEvent {
  const OnAnimationEnded();

  @override
  List<Object?> get props => [];
}
