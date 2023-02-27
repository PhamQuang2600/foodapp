part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadingEvent extends CartEvent {}

class AddCartEvent extends CartEvent {
  final Product product;

  const AddCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveCartEvent extends CartEvent {
  final Product product;

  const RemoveCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteCartEvent extends CartEvent {
  final Product product;

  const DeleteCartEvent(this.product);

  @override
  List<Object> get props => [product];
}
