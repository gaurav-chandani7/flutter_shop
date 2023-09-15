part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class ChangeAuthMode extends LoginScreenEvent {}

class LoginRegisterUserEvent extends LoginScreenEvent {
  final String email;
  final String password;
  final Function(String) onError;
  LoginRegisterUserEvent({required this.email, required this.password, required this.onError});
}
