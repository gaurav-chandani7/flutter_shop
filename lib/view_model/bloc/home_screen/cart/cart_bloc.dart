import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/cart_item.dart';
import '../../../../models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required String email}) : super(CartInitial()) {
    final cartRef = FirebaseFirestore.instance
        .collection('user-data')
        .doc(email)
        .collection('cart')
        .withConverter<CartItem>(
          fromFirestore: (snapshots, _) => CartItem.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    on<FetchCartFromBackend>((event, emit) async {
      var list = (await cartRef.get()).docs;
      var productList = list
          .map(
            (e) => e.data(),
          )
          .toList();
      emit(CartLoaded(cartItems: productList, cartTotal: _getGrandTotal()));
    });
    on<AddToCartEvent>((event, emit) {
      if (state.cartItems.any((element) => element.id == event.product.id)) {
        //Already present in cart, increase qty
        state.cartItems
                .firstWhere((element) => element.id == event.product.id)
                .quantity! +
            1;
      } else {
        //Not present in cart
        var product = event.product;
        var cartItem = CartItem(
            quantity: 1,
            category: product.category,
            id: product.id,
            title: product.title,
            description: product.description,
            image: product.image,
            rating: product.rating,
            price: product.price);
        state.cartItems.add(cartItem);
        cartRef.add(cartItem);
      }
      emit(CartLoaded(cartItems: state.cartItems, cartTotal: _getGrandTotal()));
    });
    on<RemoveFromCartEvent>((event, emit) async {
      state.cartItems.removeWhere((element) => element.id == event.id);
      var querySnapshot = await cartRef.where('id', isEqualTo: event.id).get();
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
      emit(CartLoaded(cartItems: state.cartItems, cartTotal: _getGrandTotal()));
    });
    on<IncreaseQuantityOfItemCartEvent>((event, emit) async {
      var cartItem = state.cartItems
          .firstWhere((element) => element.id == event.product.id);
      cartItem.quantity = cartItem.quantity! + 1;
      var querySnapshot =
          await cartRef.where('id', isEqualTo: event.product.id).get();
      for (var doc in querySnapshot.docs) {
        doc.reference.update({
          "quantity": state.cartItems
              .firstWhere((element) => element.id == event.product.id)
              .quantity
        });
      }
      emit(CartLoaded(cartItems: state.cartItems, cartTotal: _getGrandTotal()));
    });
    on<DecreaseQuantityOfItemCartEvent>((event, emit) async {
      if (state.cartItems
              .firstWhere((element) => element.id == event.product.id)
              .quantity! >
          1) {
        //Qty is more than 1, qty can be decreased
        var cartItem = state.cartItems
            .firstWhere((element) => element.id == event.product.id);
        cartItem.quantity = cartItem.quantity! - 1;
        var querySnapshot =
            await cartRef.where('id', isEqualTo: event.product.id).get();
        for (var doc in querySnapshot.docs) {
          doc.reference.update({
            "quantity": state.cartItems
                .firstWhere((element) => element.id == event.product.id)
                .quantity
          });
        }
        emit(CartLoaded(
            cartItems: state.cartItems, cartTotal: _getGrandTotal()));
      } else {
        add(RemoveFromCartEvent(id: event.product.id!));
      }
    });
    on<ClearCartEvent>((event, emit) async {
      var snapshots = await cartRef.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      event.onSuccess();
      emit(const CartLoaded(cartItems: [], cartTotal: 0));
    });
  }
  _getGrandTotal() {
    num grandTotal = 0;
    for (var element in state.cartItems) {
      grandTotal += element.quantity! * element.price!;
    }
    return grandTotal;
  }
}
