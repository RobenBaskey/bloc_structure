// ignore_for_file: avoid_dynamic_calls, unnecessary_cast

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repo/login_repo.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginRepo}) : super(const LoginInitial()) {
    on<LoginRequested>(_onLoginRequest);
  }

  final LoginRepository loginRepo;

  // on success login event
  FutureOr<void> _onLoginRequest(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginRepo.login(
      event.email,
      event.password,
    );
    result.fold((exception){
       emit(LoginFailed());
    }, (data){
      emit(LoginSuccess(data));
    });
  }


}
