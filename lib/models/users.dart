import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  String id;
  String fullName;
  String email;
  String address;
  String numberPhone;
  String image;

  User({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.numberPhone = '',
    this.image = '',
  });

  User copyWith({
    final String? id,
    final String? fullName,
    final String? email,
    final String? address,
    final String? numberPhone,
    final String? image,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      numberPhone: numberPhone ?? this.numberPhone,
      image: image ?? this.image,
    );
  }

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      numberPhone: snap['numberPhone'],
      image: snap['image'],
    );
    return user;
  }

  Map<String, Object> toDoc() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'numberPhone': numberPhone,
      'image': image,
    };
  }

  @override
  List<Object> get props => [
        id,
        fullName,
        email,
        address,
        numberPhone,
        image,
      ];
}
