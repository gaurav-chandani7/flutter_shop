import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Icon(
                          Icons.check,
                          size: 50,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Order Placed Successfully"),
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ElevatedButton(
                    child: const Text("Go back Home"),
                    onPressed: () {
                      // Navigator.of(context)
                      //     .popUntil((route) => route.isFirst);
                      while (Navigator.canPop(context)) {
                        Navigator.of(context).pop(true);
                      }
                    },
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
