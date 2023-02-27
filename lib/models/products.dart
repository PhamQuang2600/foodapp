import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String image;
  final List<dynamic> imageProducts;
  final String category;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product(this.name, this.image, this.imageProducts, this.category,
      this.price, this.isRecommended, this.isPopular);
  @override
  List<Object> get props =>
      [name, image, imageProducts, category, price, isRecommended, isPopular];

  static Product productSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        snap['name'],
        snap['image'],
        snap['listImage'],
        snap['category'],
        snap['price'],
        snap['isRecommended'],
        snap['isPopular']);
    return product;
  }
}
