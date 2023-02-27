import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:foodapp/models/products.dart';

class Orders extends Equatable {
  final String? id;
  final String? fullName;
  final String uid;
  final String? email;
  final String? address;
  final String? numberPhone;
  final List<Product>? products;
  final double? subtotal;
  final double? total;
  final double? deliveryFee;
  final DateTime? dateTime;

  const Orders(
      {required this.id,
      required this.uid,
      required this.fullName,
      required this.email,
      required this.address,
      required this.numberPhone,
      required this.products,
      required this.subtotal,
      required this.total,
      required this.deliveryFee,
      required this.dateTime});

  @override
  List<Object?> get props => [
        id,
        uid,
        fullName,
        email,
        address,
        numberPhone,
        products,
        subtotal,
        total,
        deliveryFee,
        dateTime
      ];

  static fromSnapshot(DocumentSnapshot snap) => Orders(
      id: snap.id,
      uid: snap['uid'],
      fullName: snap['customName'],
      email: snap['email'],
      address: snap['address'],
      numberPhone: snap['numberPhone'],
      products: snap['products'],
      subtotal: snap['subtotal'],
      total: snap['total'],
      deliveryFee: snap['deliveryFee'],
      dateTime: snap['dateTime']);
}
