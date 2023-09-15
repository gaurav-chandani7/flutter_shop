import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view/screens/checkout_screen.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/cart/cart_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/home_screen_bloc.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        if (cartState.cartItems.isEmpty) {
          return const Center(
            child: Text(
              "Bag is Empty!",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
                flex: 80,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = cartState.cartItems[index];
                    return Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(item.image!),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text("\$${item.price} x ${item.quantity}"),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    "Item Total: \$${(item.price! * item.quantity!).toStringAsFixed(2)}")
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(RemoveFromCartEvent(id: item.id!));
                                  },
                                  icon: const Icon(Icons.remove)),
                            ))
                      ],
                    );
                  },
                  itemCount: cartState.cartItems.length,
                )),
            Expanded(
                flex: 20,
                child: Column(
                  children: [
                    SizedBox(
                      child: Text(
                        "Grand Total: \$${cartState.cartTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final cartBloc = BlocProvider.of<CartBloc>(context);
                        final homeScreenBloc =
                            BlocProvider.of<HomeScreenBloc>(context);
                        bool? res =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: cartBloc,
                                      child: CheckoutScreen(),
                                    )));
                        if (res == true) {
                          homeScreenBloc.add(ChangeTabEvent(0));
                        }
                      },
                      child: const Text(
                        "Checkout > ",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ))
          ],
        );
      },
    );
  }
}
