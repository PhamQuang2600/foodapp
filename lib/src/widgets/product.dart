import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/blocs/user/user_bloc.dart';
import 'package:foodapp/config/theme.dart';
import 'package:foodapp/models/products.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/favorite/favorite_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactory;
  final double? leftPosition;
  final bool isFavorite;
  const ProductCard(
      {super.key,
      required this.product,
      required this.widthFactory,
      this.isFavorite = false,
      this.leftPosition});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / widthFactory,
              height: 200,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 120,
              left: leftPosition == null ? 0 : leftPosition,
              right: 0,
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width / widthFactory,
                decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    firebaseAuth.currentUser != null
                        ? BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CartLoading) {
                                return const CircularProgressIndicator(
                                  color: Colors.black,
                                );
                              } else if (state is CartLoaded) {
                                return IconButton(
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(AddCartEvent(product));

                                      SnackBar snackBar = const SnackBar(
                                          content: Text('Added to your Cart!'),
                                          duration: Duration(seconds: 1));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                    ));
                              } else {
                                return const Center(
                                  child: Text('Something went wrong!'),
                                );
                              }
                            },
                          )
                        : IconButton(
                            onPressed: () {
                              SnackBar snackBar = const SnackBar(
                                  content: Text('Sign in to add cart!'),
                                  duration: Duration(seconds: 1));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            )),
                    isFavorite
                        ? BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, state) {
                              if (state is FavoriteLoading) {
                                return const CircularProgressIndicator(
                                  color: Colors.black,
                                );
                              } else if (state is FavoriteLoaded) {
                                return IconButton(
                                    onPressed: () {
                                      AlertDialog alert = AlertDialog(
                                        title: Text(
                                          'Do you want to remove item favorite?',
                                          style: theme().textTheme.headline4,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<FavoriteBloc>()
                                                    .add(RemoveFavoriteEvent(
                                                        product));

                                                SnackBar snackBar =
                                                    const SnackBar(
                                                  content: Text(
                                                      'Remove your Favorite!'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);

                                                Navigator.pop(context);
                                              },
                                              child: const Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No')),
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) => alert,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ));
                              } else {
                                return const Center(
                                  child: Text('Something went wrong!'),
                                );
                              }
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
