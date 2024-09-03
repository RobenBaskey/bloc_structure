part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashInitState extends SplashState {}

class LoginState extends SplashState {
  final String token;
  const LoginState(this.token);

  @override
  List<Object?> get props => [token];
}

class NotLoginState extends SplashState {}
