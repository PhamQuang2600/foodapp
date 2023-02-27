import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/favorites.dart';

import '../../models/products.dart';



part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading()) {
    on<LoadingFavoriteEvent>(_onLoadingFavorite);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  void _onLoadingFavorite(event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      emit(const FavoriteLoaded());
    } catch (_) {
      emit(FavoriteError());
    }
  }

  void _onAddFavorite(event, Emitter<FavoriteState> emit) {
    final state = this.state;
    if (state is FavoriteLoaded) {
      try {
        emit(FavoriteLoaded(
            favorites: Favorite(
                products: List.from(state.favorites.products)
                  ..add(event.product))));
      } catch (_) {
        emit(FavoriteError());
      }
    }
  }

  void _onRemoveFavorite(event, Emitter<FavoriteState> emit) {
    final state = this.state;
    if (state is FavoriteLoaded) {
      try {
        emit(FavoriteLoaded(
            favorites: Favorite(
                products: List.from(state.favorites.products)
                  ..remove(event.product))));
      } catch (_) {
        emit(FavoriteError());
      }
    }
  }
}
