import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/carts.dart';
import 'package:foodapp/models/products.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartLoadingEvent>(_onLoadingCart);
    on<AddCartEvent>(_onAddCart);
    on<RemoveCartEvent>(_onRemoveCart);
    on<DeleteCartEvent>(_onDeleteCart);
  }
  void _onLoadingCart(event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddCart(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)..add(event.product))));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onRemoveCart(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onDeleteCart(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
