part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  final List<CartItem> cartItems;
  final num cartTotal;
  const CartState({required this.cartItems, required this.cartTotal});
}

final class CartInitial extends CartState {
  CartInitial() : super(cartItems: List.empty(growable: true), cartTotal: 0);
}

final class CartLoaded extends CartState {
  const CartLoaded({required List<CartItem> cartItems, required num cartTotal}) : super(cartItems: cartItems, cartTotal: cartTotal);
}
