part of 'login_screen_bloc.dart';

enum AuthMode { login, register, phone }

extension GetField on AuthMode {
  String get label => this == AuthMode.login
      ? 'Sign in'
      : this == AuthMode.phone
          ? 'Sign in'
          : 'Register';
}

@immutable
sealed class LoginScreenState {
  final AuthMode authMode;
  const LoginScreenState(this.authMode);
}

final class LoginScreenInitial extends LoginScreenState {
  const LoginScreenInitial() : super(AuthMode.login);
}

class LoginAuthModeState extends LoginScreenState {
  const LoginAuthModeState() : super(AuthMode.login);
}

class RegisterAuthModeState extends LoginScreenState {
  const RegisterAuthModeState() : super(AuthMode.register);
}

class LoadingLoginScreenState extends LoginScreenState {
  const LoadingLoginScreenState(AuthMode authMode) : super(authMode);
}
