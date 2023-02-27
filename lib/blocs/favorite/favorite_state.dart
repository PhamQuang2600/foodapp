part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final Favorite favorites;
  const FavoriteLoaded({this.favorites = const Favorite()});

  @override
  List<Object> get props => [favorites];
}

class FavoriteError extends FavoriteState {}
