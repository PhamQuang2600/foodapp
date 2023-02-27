part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
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
  final Checkout checkout;

  CheckoutLoaded({
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
  }) : checkout = Checkout(
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

class CheckoutError extends CheckoutState {}
