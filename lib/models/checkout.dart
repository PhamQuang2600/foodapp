import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:foodapp/models/products.dart';

class Checkout extends Equatable {
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

  const Checkout(
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

  static Checkout fromSnapshot(DocumentSnapshot snap) => Checkout(
      id: snap['id'],
      uid: snap['uid'],
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      numberPhone: snap['numberPhone'],
      products: snap['products'],
      subtotal: snap['subtotal'],
      total: snap['total'],
      deliveryFee: snap['deliveryFee'],
      dateTime: snap['dateTime']);
  Map<String, Object> toDoc() {
    return {
      'id': id!,
      'uid': uid,
      'customName': fullName!,
      'address': address!,
      'email': email!,
      'numberPhone': numberPhone!,
      'products': products!.map((product) => product.name).toList(),
      'subtotal': subtotal!,
      'total': total!,
      'deliveryFee': deliveryFee!,
      'dateTime': DateTime.now(),
    };
  }
}
