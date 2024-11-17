part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashAnimationEnd extends SplashState {}

class SplashAnimationStarted extends SplashState {}
