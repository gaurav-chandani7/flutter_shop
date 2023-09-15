part of 'checkout_screen_bloc.dart';

@immutable
sealed class CheckoutScreenState {
  final ShippingAddress shippingAddress;
  const CheckoutScreenState(this.shippingAddress);
}

final class CheckoutScreenInitial extends CheckoutScreenState {
  CheckoutScreenInitial() : super(ShippingAddress.initial());
}

final class CheckoutScreenAddressEnteredState extends CheckoutScreenState {
  const CheckoutScreenAddressEnteredState({required ShippingAddress address})
      : super(address);
}
