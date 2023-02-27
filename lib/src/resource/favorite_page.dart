import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/config/theme.dart';

import '../../blocs/favorite/favorite_bloc.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/product.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  static const String routeName = '/favorite';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const FavoritePage());
  }

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorite'),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteLoaded) {
            return state.favorites.products.length == 0
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No items in Favorite',
                            style: theme().textTheme.headline4),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              'Get My Favorite Now!',
                              style: theme()
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ))
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1.7),
                    itemCount: state.favorites.products.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ProductCard(
                          product: state.favorites.products[index],
                          widthFactory: 1,
                          leftPosition: 200,
                          isFavorite: true,
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
