import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:meta/meta.dart';

part 'shop_tab_event.dart';
part 'shop_tab_state.dart';

class ShopTabBloc extends Bloc<ShopTabEvent, ShopTabState> {
  ShopTabBloc() : super(ShopTabInitial()) {
    final productsRef = FirebaseFirestore.instance
        .collection('all-products')
        .withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    on<FetchProductsEvent>((event, emit) async {
      emit(ShopTabLoading());
      var list = (await productsRef.get()).docs;
      emit(ShopTabLoaded(productList: list));
    });
  }
}
