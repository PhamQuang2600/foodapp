part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadingFavoriteEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final Product product;

  const AddFavoriteEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final Product product;

  const RemoveFavoriteEvent(this.product);

  @override
  List<Object> get props => [product];
}
