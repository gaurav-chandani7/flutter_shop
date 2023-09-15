part of 'shop_tab_bloc.dart';

@immutable
sealed class ShopTabEvent {}

class FetchProductsEvent extends ShopTabEvent {}
