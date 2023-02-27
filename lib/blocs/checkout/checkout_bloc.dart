import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/blocs/cart/cart_bloc.dart';
import 'package:foodapp/models/checkout.dart';
import 'package:foodapp/repository/checkout_repo.dart';

import '../../models/carts.dart';
import '../../models/products.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _checkoutSub;
  StreamSubscription? _cartSub;

  CheckoutBloc(
      {required CartBloc cartBloc,
      required CheckoutRepository checkoutRepository})
      : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded
            ? CheckoutLoaded(
                uid: FirebaseAuth.instance.currentUser!.uid,
                products: (cartBloc.state as CartLoaded).cart.products,
                subtotal: (cartBloc.state as CartLoaded).cart.subtotal,
                total: (cartBloc.state as CartLoaded).cart.total,
                deliveryFee: (cartBloc.state as CartLoaded)
                    .cart
                    .deliveryFee((cartBloc.state as CartLoaded).cart.subtotal),
              )
            : CheckoutLoading()) {
    _cartSub = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(
            uid: FirebaseAuth.instance.currentUser!.uid, cart: state.cart));
      }
    });
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);
    on<GetCheckout>(_onGetCheckout);
  }

  void _onUpdateCheckout(UpdateCheckout event, Emitter<CheckoutState> emit) {
    final state = this.state;
    final user = FirebaseAuth.instance.currentUser;
    if (state is CheckoutLoaded) {
      emit(CheckoutLoaded(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: user!.email.toString(),
        fullName: user.displayName.toString(),
        address: event.address ?? state.address,
        total: event.cart?.total ?? state.total,
        subtotal: event.cart?.subtotal ?? state.subtotal,
        deliveryFee:
            event.cart?.deliveryFee(event.cart?.subtotal) ?? state.deliveryFee,
        products: event.cart?.products ?? state.products,
        numberPhone: event.numberPhone ?? state.numberPhone,
      ));
    }
  }

  void _onConfirmCheckout(
      ConfirmCheckout event, Emitter<CheckoutState> emit) async {
    _checkoutSub?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
      } catch (_) {}
    }
  }

  void _onGetCheckout(GetCheckout event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    try {
      await _checkoutRepository
          .getCheckout(FirebaseAuth.instance.currentUser!.uid);
      emit(CheckoutLoaded(uid: FirebaseAuth.instance.currentUser!.uid));
    } catch (e) {
      emit(CheckoutError());
    }
  }
}
