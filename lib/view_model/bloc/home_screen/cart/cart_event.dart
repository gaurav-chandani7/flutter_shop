part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchCartFromBackend extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  final int id;
  RemoveFromCartEvent({required this.id});
}

class IncreaseQuantityOfItemCartEvent extends CartEvent {
  final Product product;
  IncreaseQuantityOfItemCartEvent({required this.product});
}

class DecreaseQuantityOfItemCartEvent extends CartEvent {
  final Product product;
  DecreaseQuantityOfItemCartEvent({required this.product});
}

class ClearCartEvent extends CartEvent {
  final Function onSuccess;
  ClearCartEvent({required this.onSuccess});
}
