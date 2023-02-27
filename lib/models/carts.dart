import 'package:equatable/equatable.dart';
import 'package:foodapp/models/products.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  Map productQuantity(product) {
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFee(subtotal) {
    if (subtotal >= 20) {
      return 0;
    } else if (subtotal == 0) {
      return 0;
    } else {
      return 10;
    }
  }

  String freeDelivery(double subtotal) {
    if (subtotal >= 20) {
      return 'You have Free Delivery';
    } else {
      double missing = 20 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for Free Delivery';
    }
  }

  double get total => subtotal + deliveryFee(subtotal);

  @override
  List<Object?> get props => [products];
}
