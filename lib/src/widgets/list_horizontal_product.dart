import 'package:flutter/material.dart';
import 'package:foodapp/src/widgets/product.dart';

import '../../models/products.dart';

class HorizoltalProduct extends StatelessWidget {
  final List<Product> products;
  const HorizoltalProduct(
    this.products, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              widthFactory: 2.5,
            );
          }),
    );
  }
}
