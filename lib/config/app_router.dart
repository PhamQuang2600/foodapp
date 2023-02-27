import 'package:flutter/material.dart';
import 'package:foodapp/models/categories.dart';
import 'package:foodapp/models/products.dart';
import 'package:foodapp/src/resource/cart_page.dart';
import 'package:foodapp/src/resource/catalog_page.dart';
import 'package:foodapp/src/resource/checkout_page.dart';
import 'package:foodapp/src/resource/favorite_page.dart';
import 'package:foodapp/src/resource/home.dart';
import 'package:foodapp/src/resource/order_confirm_page.dart';
import 'package:foodapp/src/resource/product_page.dart';
import 'package:foodapp/src/resource/search_page.dart';
import 'package:foodapp/src/resource/splash_page.dart';
import 'package:foodapp/src/resource/user_page.dart';

import '../src/resource/signin_page.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return HomePage.route();

      case CartPage.routeName:
        return CartPage.route();

      case SplashPage.routeName:
        return SplashPage.route();

      case CheckoutPage.routeName:
        return CheckoutPage.route();

      case SearchPage.routeName:
        return SearchPage.route();

      case OrderConfirmPage.routeName:
        return OrderConfirmPage.route();

      case CatalogPage.routeName:
        return CatalogPage.route(category: settings.arguments as Category);

      case FavoritePage.routeName:
        return FavoritePage.route();

      case SignInPage.routeName:
        return SignInPage.route();

      case UserPage.routeName:
        return UserPage.route();

      case ProductPage.routeName:
        return ProductPage.route(product: settings.arguments as Product);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
            ));
  }
}
