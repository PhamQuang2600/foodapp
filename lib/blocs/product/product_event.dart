part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductLoadEvent extends ProductEvent {}

class ProductLoadedEvent extends ProductEvent {
  final List<Product> products;

  const ProductLoadedEvent(this.products);

  @override
  List<Object> get props => [products];
}

class ProductSearchLoadedEvent extends ProductEvent {
  final String search;

  const ProductSearchLoadedEvent(this.search);

  @override
  List<Object> get props => [search];
}

class ProductLoadSearchEvent extends ProductEvent {
  final List<Product> products;

  const ProductLoadSearchEvent(this.products);

  @override
  List<Object> get props => [products];
}
