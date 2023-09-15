part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class ChangeTabEvent extends HomeScreenEvent {
  final int index;
  ChangeTabEvent(this.index);
}
