import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/repository/order_repo.dart';

import '../../models/orders.dart';
import '../../models/products.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _orderSub;
  OrderBloc(this._orderRepository) : super(OrderLoading()) {
    on<GetOrder>(_onGetOrder);
  }
  void _onGetOrder(GetOrder event, Emitter<OrderState> emit) async {
    _orderSub?.cancel();
    try {
      _orderRepository
          .getOrder(FirebaseAuth.instance.currentUser!.uid)
          .listen((orders) => add(OrderLoadedEvent(orders)));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
