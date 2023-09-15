import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view/screens/confirm_order_screen.dart';
import 'package:flutter_shop/view_model/bloc/checkout_screen/checkout_screen_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/cart/cart_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutScreenBloc(formKey: _formKey),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SafeArea(
          top: false,
          child: BlocBuilder<CheckoutScreenBloc, CheckoutScreenState>(
            builder: (context, checkoutScreenState) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  title: const Text("Add Address"),
                ),
                body: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Name *"),
                              validator: nameFieldValidator,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              onSaved: (newValue) => checkoutScreenState
                                  .shippingAddress.name = newValue ?? "",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Mobile *"),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              validator: mobileFieldValidator,
                              enableInteractiveSelection: false,
                              onSaved: (newValue) =>
                                  checkoutScreenState.shippingAddress.mobile =
                                      (newValue == null
                                          ? null
                                          : num.tryParse(newValue)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 35,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: "Pincode *"),
                                    validator: pinFieldValidator,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    enableInteractiveSelection: false,
                                    onSaved: (newValue) => checkoutScreenState
                                            .shippingAddress.pincode =
                                        (newValue == null
                                            ? null
                                            : num.tryParse(newValue)),
                                  ),
                                ),
                                const Expanded(
                                  flex: 15,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 50,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: "State *"),
                                    validator: (val) =>
                                        requiredValidator(val, "State"),
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    onSaved: (newValue) => checkoutScreenState
                                        .shippingAddress.state = newValue ?? "",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText:
                                      "Address(House No, Building, Street, Area) *"),
                              validator: (val) =>
                                  requiredValidator(val, "Address"),
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.sentences,
                              onSaved: (newValue) => checkoutScreenState
                                  .shippingAddress.address = newValue ?? "",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Locality/Town *"),
                              validator: (val) =>
                                  requiredValidator(val, "Locality/Town"),
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.sentences,
                              onSaved: (newValue) => checkoutScreenState
                                  .shippingAddress.town = newValue ?? "",
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          child: StatefulBuilder(
                              builder: (context, typeOfAddressState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Type of Address"),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: const Text("Home"),
                                        horizontalTitleGap: 2,
                                        onTap: () {
                                          typeOfAddressState(() =>
                                              checkoutScreenState
                                                  .shippingAddress
                                                  .typeOfAddress = "Home");
                                        },
                                        leading: Radio.adaptive(
                                            value: 'Home',
                                            groupValue: checkoutScreenState
                                                .shippingAddress.typeOfAddress,
                                            onChanged: (_) {
                                              typeOfAddressState(() =>
                                                  checkoutScreenState
                                                      .shippingAddress
                                                      .typeOfAddress = _);
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: const Text("Office"),
                                        horizontalTitleGap: 2,
                                        onTap: () {
                                          typeOfAddressState(() =>
                                              checkoutScreenState
                                                  .shippingAddress
                                                  .typeOfAddress = "Office");
                                        },
                                        leading: Radio.adaptive(
                                            value: 'Office',
                                            groupValue: checkoutScreenState
                                                .shippingAddress.typeOfAddress,
                                            onChanged: (_) {
                                              typeOfAddressState(() =>
                                                  checkoutScreenState
                                                      .shippingAddress
                                                      .typeOfAddress = _);
                                            }),
                                      ),
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                )
                              ],
                            );
                          })),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CheckoutScreenBloc>(context)
                                .add(ValidateFormEvent(onSuccess: () {
                              final checkoutScreenBloc =
                                  BlocProvider.of<CheckoutScreenBloc>(context);
                              final cartBloc =
                                  BlocProvider.of<CartBloc>(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                            value: checkoutScreenBloc,
                                          ),
                                          BlocProvider.value(
                                            value: cartBloc,
                                          ),
                                        ],
                                        child: const ConfirmOrderScreen(),
                                      )));
                            }));
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 19),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
