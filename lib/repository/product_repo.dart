import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/models/products.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.productSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProductSearch(String search) {
    return _firebaseFirestore
        .collection('products')
        .where('name', arrayContains: search)
        
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.productSnapshot(doc)).toList();
    });
  }
}
