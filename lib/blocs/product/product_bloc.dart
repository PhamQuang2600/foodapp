import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/repository/product_repo.dart';

import '../../models/products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productStreamsubscription;
  ProductBloc(ProductRepository productRepository)
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<ProductLoadEvent>(_onLoadProduct);
    on<ProductLoadedEvent>(_onLoadedProduct);
    on<ProductSearchLoadedEvent>(_onProductSearch);
    on<ProductLoadSearchEvent>(_onSearchLoaded);
  }

  void _onLoadProduct(event, Emitter<ProductState> emit) async {
    _productStreamsubscription?.cancel();
    _productStreamsubscription = _productRepository
        .getAllProducts()
        .listen((products) => add(ProductLoadedEvent(products)));
  }

  void _onLoadedProduct(event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }

  void _onProductSearch(event, Emitter<ProductState> emit) {
    _productStreamsubscription?.cancel();
    try {
      _productStreamsubscription = _productRepository
          .getProductSearch(event.search)
          .listen((products) => ProductLoadSearchEvent(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSearchLoaded(event, Emitter<ProductState> emit) {
    emit(ProductSearchLoaded(products: event.products));
  }
}
