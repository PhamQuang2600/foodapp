part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final String? id;
  final String uid;
  final String? fullName;
  final String? email;
  final String? address;
  final String? numberPhone;
  final List<Product>? products;
  final double? subtotal;
  final double? total;
  final double? deliveryFee;
  final DateTime? dateTime;
  final Orders orders;

  OrderLoaded({
    this.id,
    required this.uid,
    this.fullName,
    this.email,
    this.address,
    this.numberPhone,
    this.products,
    this.subtotal,
    this.total,
    this.deliveryFee,
    this.dateTime,
  }) : orders = Orders(
            id: id,
            uid: uid,
            fullName: fullName,
            email: email,
            address: address,
            numberPhone: numberPhone,
            products: products,
            subtotal: subtotal,
            total: total,
            deliveryFee: deliveryFee,
            dateTime: dateTime);

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
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);
  @override
  List<Object> get props => [message];
}
