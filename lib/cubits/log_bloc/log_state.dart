part of 'log_bloc.dart';

@immutable
abstract class LogState {}

class LogInitialState extends LogState {}

class LoginSuccessState extends LogState {}

class LoginLoadingState extends LogState {}

class LoginFailureState extends LogState {
  final String err;

  LoginFailureState({required this.err});
}
