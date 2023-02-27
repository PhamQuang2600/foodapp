import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/config/theme.dart';
import 'package:foodapp/models/products.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/favorite/favorite_bloc.dart';
import '../widgets/carousel_hero.dart';
import '../widgets/custom_appbar.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  static const String routeName = '/product';
  static Route route({required Product product}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ProductPage(
              product: product,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteLoading) {
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  } else if (state is FavoriteLoaded) {
                    return IconButton(
                      onPressed: () {
                        context
                            .read<FavoriteBloc>()
                            .add(AddFavoriteEvent(product));

                        SnackBar snackBar = const SnackBar(
                          content: Text('Added to your Favorite!'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  } else if (state is CartLoaded) {
                    return MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      color: Colors.white,
                      onPressed: () {
                        context.read<CartBloc>().add(AddCartEvent(product));

                        SnackBar snackBar = const SnackBar(
                          content: Text('Add to your Cart success!'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(
                        'ADD TO CART',
                        style: theme().textTheme.headline3,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.9,
                aspectRatio: 1.5,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: [HeroCarousel(product: product)],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withAlpha(50),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      height: 50,
                      color: Colors.black,
                      padding: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          Text(
                            '\$${product.price}',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  'Product Information',
                  style: Theme.of(context).textTheme.headline3,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
                      style: theme().textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text(
                  'Deliver Information',
                  style: Theme.of(context).textTheme.headline3,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
                      style: theme().textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
