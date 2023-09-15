part of 'checkout_screen_bloc.dart';

@immutable
sealed class CheckoutScreenEvent {}

class ValidateFormEvent extends CheckoutScreenEvent {
  final Function onSuccess;
  ValidateFormEvent({required this.onSuccess});
}
