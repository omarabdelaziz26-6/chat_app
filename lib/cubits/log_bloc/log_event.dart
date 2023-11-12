part of 'log_bloc.dart';

@immutable
abstract class LogEvent {}

class LoginEvents extends LogEvent {
  final String? emailInput, passwordInput;
  LoginEvents({required this.emailInput, required this.passwordInput});
}
