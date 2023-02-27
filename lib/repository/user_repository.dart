import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toDoc());
  }

  getUser(String userId) {
    return _firebaseFirestore.collection('users').doc(userId).get();
  }

  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDoc());
  }
}
