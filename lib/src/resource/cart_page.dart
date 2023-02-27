import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/config/theme.dart';
import 'package:foodapp/src/widgets/show_cart.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/ordersummary_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String routeName = '/cart';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CartPage());
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator(
            color: Colors.grey,
          );
        } else if (state is CartLoaded) {
          return state.cart.products.length == 0
              ? Scaffold(
                  appBar: const CustomAppBar(title: 'Cart'),
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No items in cart',
                        style: theme().textTheme.headline3,
                      ),
                      MaterialButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/',
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Go to Shopping',
                          style: theme()
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  )),
                )
              : Scaffold(
                  appBar: const CustomAppBar(title: 'Cart'),
                  bottomNavigationBar: BottomAppBar(
                      height: 60,
                      color: Colors.black,
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/checkout');
                            },
                            child: Text(
                              'GO TO CHECK OUT',
                              style: theme().textTheme.headline4,
                            ),
                          )
                        ],
                      )),
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.cart
                                        .freeDelivery(state.cart.subtotal),
                                    style: theme().textTheme.headline5,
                                  ),
                                  MaterialButton(
                                      color: Colors.black,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/');
                                      },
                                      child: Text(
                                        'Add More Items',
                                        style: theme()
                                            .textTheme
                                            .headline5!
                                            .copyWith(color: Colors.white),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 500,
                                child: ListView.builder(
                                  itemCount: state.cart
                                      .productQuantity(state.cart.products)
                                      .keys
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ShowCart(
                                      product: state.cart
                                          .productQuantity(state.cart.products)
                                          .keys
                                          .elementAt(index),
                                      quantity: state.cart
                                          .productQuantity(state.cart.products)
                                          .values
                                          .elementAt(index),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const OrderSummaryPage(),
                        ],
                      ),
                    ),
                  ),
                );
        } else {
          return Center(
            child: Text(
              'Something went wrong!',
              style: theme().textTheme.headline3,
            ),
          );
        }
      },
    );
  }
}
