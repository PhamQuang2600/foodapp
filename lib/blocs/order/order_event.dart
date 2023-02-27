part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrder extends OrderEvent {
  @override
  List<Object> get props => [];
}

class OrderLoadedEvent extends OrderEvent {
  final List<Orders> orders;

  const OrderLoadedEvent(this.orders);

  @override
  List<Object> get props => [orders];
}
