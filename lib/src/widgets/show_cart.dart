import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/products.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../config/theme.dart';

class ShowCart extends StatelessWidget {
  final Product product;
  final int quantity;
  const ShowCart({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  product.image,
                  width: 100,
                  height: 80,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: theme().textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveCartEvent(product));
                        },
                        icon: const Icon(Icons.remove_circle));
                  },
                ),
                Text(
                  quantity.toString(),
                  style: theme().textTheme.headline5,
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddCartEvent(product));
                        },
                        icon: const Icon(Icons.add_circle));
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
