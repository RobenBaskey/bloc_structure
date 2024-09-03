part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super();
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.token);
   final String token;

  @override
  List<Object> get props => [token];
}

class LoginFailed extends LoginState {}
