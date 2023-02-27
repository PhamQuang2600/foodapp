import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/src/widgets/custom_bottom.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/product/product_bloc.dart';
import '../widgets/carousel_hero.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/list_horizontal_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Food App Order',
        isHome: true,
      ),
      bottomNavigationBar: const CustomBottom(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.9,
                        aspectRatio: 1.5,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: state.categories
                          .map((cate) => HeroCarousel(
                                category: cate,
                              ))
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'RECOMMENDED',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ProductLoaded) {
                    return HorizoltalProduct(
                      state.products
                          .where((element) => element.isRecommended == true)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'MOST POPULAR',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ProductLoaded) {
                    return HorizoltalProduct(
                      state.products
                          .where((element) => element.isPopular == true)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
