import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../config/theme.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: theme().textTheme.headline3,
        ),
        const Divider(
          thickness: 2,
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Container();
            } else if (state is CartLoaded) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SUBTOTAL',
                              style: theme().textTheme.headline4,
                            ),
                            Text(
                              '\$${state.cart.subtotal.toStringAsFixed(2)}',
                              style: theme().textTheme.headline5,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DELIVERY FREE',
                              style: theme().textTheme.headline4,
                            ),
                            Text(
                              '\$${state.cart.deliveryFee(state.cart.subtotal).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration:
                            BoxDecoration(color: Colors.black.withAlpha(50)),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TOTAL',
                                  style: theme()
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  '\$${state.cart.total.toStringAsFixed(2)}',
                                  style: theme()
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          },
        ),
      ],
    );
  }
}
