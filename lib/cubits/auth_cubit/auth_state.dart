part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginSuccessState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginFailureState extends AuthState {
  final String err;

  LoginFailureState({required this.err});
}

class SignUpSuccessState extends AuthState {}

class SignUpLoadingState extends AuthState {}

class SignUpFailureState extends AuthState {
  final String err;

  SignUpFailureState({required this.err});
}
