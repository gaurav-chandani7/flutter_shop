import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenInitial()) {
    on<ChangeTabEvent>((event, emit) {
      if (event.index == 0) {
        emit(const ShopTabActiveState());
      } else if (event.index == 1) {
        emit(const CartTabActiveState());
      } else {
        emit(const ProfileTabActiveState());
      }
    });
  }
}
