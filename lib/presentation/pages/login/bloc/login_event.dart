part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_login_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomLoginEvent extends LoginEvent {
  /// {@macro custom_login_event}
  const CustomLoginEvent();
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginSuccessEvent extends LoginEvent {
  final String token;

  const LoginSuccessEvent(this.token);

  @override
  List<Object> get props => [];
}