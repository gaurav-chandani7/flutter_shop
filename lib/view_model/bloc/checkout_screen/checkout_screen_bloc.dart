import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/shipping_address.dart';
import 'package:meta/meta.dart';

part 'checkout_screen_event.dart';
part 'checkout_screen_state.dart';

class CheckoutScreenBloc
    extends Bloc<CheckoutScreenEvent, CheckoutScreenState> {
  CheckoutScreenBloc({GlobalKey<FormState>? formKey})
      : super(CheckoutScreenInitial()) {
    on<ValidateFormEvent>((event, emit) {
      if (formKey?.currentState?.validate() ?? false) {
        formKey?.currentState?.save();
        event.onSuccess();
      }
    });
  }
}

//validators
String? Function(String?) nameFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    return null;
  }
  return "Name Required";
};

String? Function(String?) mobileFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    if (value.length != 10) {
      return "Invalid Mobile No.";
    }
    return null;
  }
  return "Mobile No. Required";
};

String? Function(String?) pinFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    if (value.length != 6) {
      return "Invalid Pincode";
    }
    return null;
  }
  return "Pincode Required";
};

String? Function(String?, String) requiredValidator = (value, fieldName) {
  if (value != null && value.isNotEmpty) {
    return null;
  }
  return "$fieldName Required";
};
