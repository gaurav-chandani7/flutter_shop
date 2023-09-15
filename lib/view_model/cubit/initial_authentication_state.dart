part of 'initial_authentication_cubit.dart';

@immutable
sealed class InitialAuthenticationState {
  final FirebaseAuth auth;
  const InitialAuthenticationState(this.auth);
}

final class InitialAuthenticationInitial extends InitialAuthenticationState {
  const InitialAuthenticationInitial(FirebaseAuth auth) : super(auth);
}

class LoggedInState extends InitialAuthenticationState {
  const LoggedInState(FirebaseAuth auth) : super(auth);
}

class LoggedOutState extends InitialAuthenticationState {
  const LoggedOutState(FirebaseAuth auth) : super(auth);
}
