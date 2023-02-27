import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String image;
  const Category(this.name, this.image);

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(snap['name'], snap['image']);
    return category;
  }

  @override
  List<Object?> get props => [name, image];
}
