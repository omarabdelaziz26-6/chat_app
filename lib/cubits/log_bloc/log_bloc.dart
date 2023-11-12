import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  bool loginIsLoading = false;

  LogBloc() : super(LogInitialState()) {
    on<LogEvent>((event, emit) async {
      if (event is LoginEvents) {
        emit(LoginLoadingState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.emailInput!,
            password: event.passwordInput!,
          );
          emit(LoginSuccessState());
        } on FirebaseAuthException catch (e) {
          log(e.code.toString());
          if (e.code.toString() == 'INVALID_LOGIN_CREDENTIALS') {
            emit(LoginFailureState(
                err:
                    "No user found for this e-mail or password correct them, or try to Sign up first."));
            log(e.toString());
          } else if (e.code.toString() == "too-many-requests") {
            emit(LoginFailureState(
              err:
                  'We have blocked all requests from this device due to unusual activity. Try again later.',
            ));
            log(e.message.toString());
          } else {
            emit(LoginFailureState(
              err: "wrong",
            ));
            log(e.toString());
          }
        } catch (e) {
          emit(LoginFailureState(
            err: e.toString(),
          ));
        }
      }
    });
  }
}
