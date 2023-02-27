import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:foodapp/models/checkout.dart';

class CheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(
          checkout.toDoc(),
        );
  }

  getCheckout(String uid) {
    return _firebaseFirestore
        .collection('checkout')
        .orderBy('dateTime', descending: true)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .then((snapshot) => Checkout.fromSnapshot(snapshot as DocumentSnapshot));
  }
}
