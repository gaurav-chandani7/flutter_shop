import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'initial_authentication_state.dart';

class InitialAuthenticationCubit extends Cubit<InitialAuthenticationState> {
  final FirebaseApp app;
  InitialAuthenticationCubit({required this.app})
      : super(
            InitialAuthenticationInitial(FirebaseAuth.instanceFor(app: app))) {
    _setAuthStream();
  }

  void _setAuthStream() {
    state.auth.authStateChanges().listen((event) {
      log(event.toString());
      if (event == null) {
        //Show Login Page
        emit(LoggedOutState(state.auth));
      } else {
        //Show Home page
        emit(LoggedInState(state.auth));
      }
    });
  }

  logout() async {
    await state.auth.signOut();
    emit(LoggedOutState(state.auth));
  }
}
