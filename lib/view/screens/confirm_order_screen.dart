import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view/screens/order_placed_screen.dart';
import 'package:flutter_shop/view_model/bloc/checkout_screen/checkout_screen_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/cart/cart_bloc.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingAddress =
        context.read<CheckoutScreenBloc>().state.shippingAddress;
    final cart = context.read<CartBloc>().state;
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Confirm Order"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  child: Text("Price Details",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Items: "),
                          Text("Total MRP: "),
                          Text("Shipping: "),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Total Amount: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${cart.cartItems.length}"),
                          Text("\$${(cart.cartTotal).toStringAsFixed(2)}"),
                          const Text("\$10"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$${(cart.cartTotal + 10).toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 30, child: Text("Ship to:")),
                        Expanded(
                          flex: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${shippingAddress.name}, "),
                              Text("${shippingAddress.address}, "),
                              Text(
                                  "${shippingAddress.town} ${shippingAddress.pincode}, "),
                              Text("${shippingAddress.state} "),
                              Text(
                                  "Mob: ${shippingAddress.mobile != null ? shippingAddress.mobile.toString() : ""}")
                            ],
                          ),
                        ),
                        const Expanded(flex: 20, child: SizedBox())
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(ClearCartEvent(onSuccess: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const OrderPlacedScreen()));
                          }));
                        },
                        child: const Text("Place Order")),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
