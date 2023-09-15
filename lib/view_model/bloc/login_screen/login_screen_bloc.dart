import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc(GlobalKey<FormState> formKey, FirebaseAuth firebaseAuth)
      : super(const LoginScreenInitial()) {
    on<ChangeAuthMode>((event, emit) {
      if (state.authMode == AuthMode.register) {
        emit(const LoginAuthModeState());
      } else {
        emit(const RegisterAuthModeState());
      }
    });
    on<LoginRegisterUserEvent>((event, emit) async {
      if (formKey.currentState?.validate() ?? false) {
        emit(LoadingLoginScreenState(state.authMode));
        if (state.authMode == AuthMode.login) {
          try {
            await firebaseAuth.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
          } catch (e) {
            if (e is FirebaseAuthException) {
              event.onError(e.message ?? "");
            } else {
              event.onError("Something went wrong!");
            }
            log(e.toString());
          }
          emit(const LoginAuthModeState());
        } else {
          try {
            var res = await firebaseAuth.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            log(res.toString());
          } catch (e) {
            if (e is FirebaseAuthException) {
              event.onError(e.message ?? "");
            } else {
              event.onError("Something went wrong!");
            }
            log(e.toString());
          }
          emit(const RegisterAuthModeState());
        }
      }
    });
  }
}

String? Function(String?) emailFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    if (!validateEmail(value)) {
      return "Enter a Valid email";
    }
  } else {
    return "Email Required";
  }
  return null;
};

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
