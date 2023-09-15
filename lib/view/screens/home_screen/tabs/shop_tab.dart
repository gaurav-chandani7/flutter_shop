import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/cart/cart_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/shop_tab/shop_tab_bloc.dart';

class ShopTab extends StatelessWidget {
  const ShopTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopTabBloc()..add(FetchProductsEvent()),
      child: SafeArea(
        child: BlocBuilder<ShopTabBloc, ShopTabState>(
          builder: (context, shopTabState) {
            if (shopTabState is ShopTabInitial ||
                shopTabState is ShopTabLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Loading Products...")
                  ],
                ),
              );
            }
            if (shopTabState is ShopTabLoaded) {
              if (shopTabState.productList!.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<ShopTabBloc>(context)
                        .add(FetchProductsEvent());
                  },
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: const Center(
                          child: Text("No Products"),
                        ),
                      ),
                    );
                  }),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ShopTabBloc>(context)
                      .add(FetchProductsEvent());
                },
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "WHAT ARE YOU LOOKING FOR?",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.6),
                      itemBuilder: (context, index) {
                        var item = shopTabState.productList![index].data();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            decoration: const BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                    color: Colors.black12, width: 0.5))),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 70,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image.network(
                                            item.image!,
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          bottom: 5,
                                          child: Container(
                                            color: Colors.white30,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 2),
                                            child: Row(
                                              children: [
                                                Text(
                                                  item.rating!.rate.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color: Colors.amber.shade700,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                Expanded(
                                    flex: 30,
                                    child: Column(
                                      children: [
                                        Text(
                                          item.title ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text("\$${item.price}"),
                                        BlocBuilder<CartBloc, CartState>(
                                          builder: (context, cartState) {
                                            return cartState.cartItems.any(
                                              (element) =>
                                                  element.id == item.id,
                                            )
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        CartBloc>(
                                                                    context)
                                                                .add(DecreaseQuantityOfItemCartEvent(
                                                                    product:
                                                                        item));
                                                          },
                                                          iconSize: 16,
                                                          icon: const Icon(
                                                              Icons.remove)),
                                                      Text(
                                                        cartState.cartItems
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    item.id)
                                                            .quantity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        CartBloc>(
                                                                    context)
                                                                .add(IncreaseQuantityOfItemCartEvent(
                                                                    product:
                                                                        item));
                                                          },
                                                          iconSize: 16,
                                                          icon: const Icon(
                                                              Icons.add)),
                                                    ],
                                                  )
                                                : TextButton(
                                                    onPressed: () {
                                                      BlocProvider.of<CartBloc>(
                                                              context)
                                                          .add(AddToCartEvent(
                                                              product: item));
                                                    },
                                                    child: const Text(
                                                        "Add to bag"),
                                                  );
                                          },
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: shopTabState.productList!.length,
                    ))
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
