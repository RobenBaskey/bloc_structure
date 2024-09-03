import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repo/splash_repo.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.splashRepo}):super( SplashInitState()) {
    on<CheckLoginEvent>(_onCheckLogin);
  }

  final SplashRepository splashRepo;

  FutureOr<void> _onCheckLogin(
    CheckLoginEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashInitState());
    final result = await splashRepo.checkLogin();
    result.fold((exception) {
      emit(NotLoginState());
    }, (data) {
      if (data != "") {
        emit(LoginState(data));
      } else {
        emit(NotLoginState());
      }
    });
  }
}
