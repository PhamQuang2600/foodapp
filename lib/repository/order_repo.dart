import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/orders.dart';

class OrderRepository {
  final FirebaseFirestore _firebaseFirestore;
  OrderRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  getOrder(String uid) {
    return _firebaseFirestore
        .collection('checkout')
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .get();
  }
}
