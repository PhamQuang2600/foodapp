import 'package:equatable/equatable.dart';
import 'package:foodapp/models/products.dart';

class Favorite extends Equatable {
  final List<Product> products;
  const Favorite({this.products = const <Product>[]});
  @override
  List<Object?> get props => [products];
}
