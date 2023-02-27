import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/src/widgets/custom_bottom.dart';
import 'package:foodapp/src/widgets/product.dart';

import '../../blocs/product/product_bloc.dart';
import '../../models/categories.dart';
import '../../models/products.dart';
import '../widgets/custom_appbar.dart';

class CatalogPage extends StatelessWidget {
  static const String routeName = '/catalog';
  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CatalogPage(category: category));
  }

  final Category category;
  const CatalogPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomBottom(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (state is ProductLoaded) {
            List<Product> products = state.products
                .where((product) => product.category == category.name)
                .toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ProductCard(
                    product: products[index],
                    widthFactory: 2,
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
