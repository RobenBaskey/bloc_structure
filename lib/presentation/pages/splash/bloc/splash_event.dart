part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CustomSplashEvent extends SplashEvent {
  const CustomSplashEvent();
}

class CheckLoginEvent extends SplashEvent {

}
