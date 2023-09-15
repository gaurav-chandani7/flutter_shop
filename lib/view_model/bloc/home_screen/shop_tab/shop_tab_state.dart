part of 'shop_tab_bloc.dart';

@immutable
sealed class ShopTabState {
  final List<QueryDocumentSnapshot<Product>>? productList;
  const ShopTabState({this.productList});
}

final class ShopTabInitial extends ShopTabState {}

final class ShopTabLoading extends ShopTabState {}

final class ShopTabLoaded extends ShopTabState {
  const ShopTabLoaded(
      {required List<QueryDocumentSnapshot<Product>> productList})
      : super(productList: productList);
}

final class ShopTabError extends ShopTabState {}
