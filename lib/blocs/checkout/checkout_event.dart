part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String uid;
  final String? fullName;
  final String? email;
  final String? address;
  final String? numberPhone;
  final List<Product>? products;
  final Cart? cart;

  const UpdateCheckout(
      {required this.uid,
      this.fullName,
      this.email,
      this.address,
      this.numberPhone,
      this.products,
      this.cart});

  @override
  List<Object?> get props =>
      [uid, fullName, email, address, numberPhone, products, cart];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;
  const ConfirmCheckout({required this.checkout});

  @override
  List<Object> get props => [checkout];
}

class GetCheckout extends CheckoutEvent {}
