import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view/screens/home_screen/tabs/cart_tab.dart';
import 'package:flutter_shop/view/screens/home_screen/tabs/profile_tab.dart';
import 'package:flutter_shop/view/screens/home_screen/tabs/shop_tab.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/cart/cart_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/home_screen_bloc.dart';
import 'package:flutter_shop/view_model/cubit/initial_authentication_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [];
  @override
  void initState() {
    super.initState();
    _tabs.addAll([const ShopTab(), const CartTab(), const ProfileTab()]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenBloc()),
        BlocProvider(
            create: (context) => CartBloc(
                email: context
                        .read<InitialAuthenticationCubit>()
                        .state
                        .auth
                        .currentUser!
                        .email ??
                    "")
              ..add(FetchCartFromBackend())),
      ],
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, homeScreenState) {
          return SafeArea(
            top: false,
            child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled), label: "Shop"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag), label: "Cart"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_2), label: "Profile"),
                  ],
                  onTap: (value) => BlocProvider.of<HomeScreenBloc>(context)
                      .add(ChangeTabEvent(value)),
                  currentIndex: homeScreenState.activeTab,
                ),
                body: IndexedStack(
                  index: homeScreenState.activeTab,
                  children: _tabs,
                )),
          );
        },
      ),
    );
  }
}
