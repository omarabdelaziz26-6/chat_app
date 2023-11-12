import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/sign_up_page.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool loginIsLoading = false;
  bool signUpIsLoading = false;
  /* 
  
  Future<void> logInFunction(
      {required String? emailInput, required String? passwordInput}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput!,
        password: passwordInput!,
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
  */

//! /////////////////////////////////////////////
  Future<void> signUpFunction(
      {required String? emailInput, required String? passwordInput}) async {
    emit(SignUpLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInput!,
        password: passwordInput!,
      );
      await SignUpPage.users
          .doc(emailInput)
          .set({kId: emailInput, kPassword: passwordInput});
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      if (e.code == 'weak-password') {
        emit(SignUpFailureState(
          err: 'Your password is too weak.',
        ));
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailureState(
          err: 'This e-mail is already exists, Try to logIn.',
        ));
        log('The account already exists for that email.');
      } else {
        emit(SignUpFailureState(
          err: e.message.toString(),
        ));
      }
    } catch (e) {
      log(e.toString());
      emit(SignUpFailureState(
        err: "There was an error",
      ));
    }
  }
}
