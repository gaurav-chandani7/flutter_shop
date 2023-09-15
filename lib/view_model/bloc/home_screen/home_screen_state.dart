part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {
  final int activeTab;
  const HomeScreenState(this.activeTab);
}

final class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial() : super(0);
}

final class ShopTabActiveState extends HomeScreenState {
  const ShopTabActiveState() : super(0);
}

final class CartTabActiveState extends HomeScreenState {
  const CartTabActiveState() : super(1);
}

final class ProfileTabActiveState extends HomeScreenState {
  const ProfileTabActiveState() : super(2);
}
