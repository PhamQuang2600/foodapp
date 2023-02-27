import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/blocs/autheticated/authenticated_bloc.dart';
import 'package:foodapp/blocs/checkout/checkout_bloc.dart';
import 'package:foodapp/blocs/order/order_bloc.dart';
import 'package:foodapp/blocs/product/product_bloc.dart';
import 'package:foodapp/blocs/user/user_bloc.dart';
import 'package:foodapp/config/app_router.dart';
import 'package:foodapp/repository/baseAuth_repository.dart';
import 'package:foodapp/repository/category_repo.dart';
import 'package:foodapp/repository/checkout_repo.dart';
import 'package:foodapp/repository/order_repo.dart';
import 'package:foodapp/repository/product_repo.dart';
import 'package:foodapp/repository/user_repository.dart';
import 'package:foodapp/src/resource/home.dart';
import 'package:foodapp/src/resource/order_confirm_page.dart';
import 'package:foodapp/src/resource/signin_page.dart';
import 'package:foodapp/src/resource/splash_page.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/favorite/favorite_bloc.dart';
import '../config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthReporitory(),
          ),
          RepositoryProvider(
            create: (context) => UserRepository(),
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      FavoriteBloc()..add(LoadingFavoriteEvent())),
              BlocProvider(create: (_) => CartBloc()..add(CartLoadingEvent())),
              BlocProvider(
                  create: (_) =>
                      CategoryBloc(categoryRepository: CategoryRepository())
                        ..add(LoadCategoryEvent())),
              BlocProvider(
                  create: (_) => ProductBloc(ProductRepository())
                    ..add(ProductLoadEvent())),
              BlocProvider(
                  create: (context) => CheckoutBloc(
                      cartBloc: context.read<CartBloc>(),
                      checkoutRepository: CheckoutRepository())),
              BlocProvider(
                create: (context) => AuthenticatedBloc(
                  authReporitory: context.read<AuthReporitory>(),
                  userRepository: context.read<UserRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    UserBloc(UserRepository())..add(const GetUserEvent()),
              ),
              BlocProvider(
                create: (context) =>
                    OrderBloc(OrderRepository())..add(GetOrder()),
              ),
            ],
            child: MaterialApp(
              title: 'Food App',
              theme: theme(),
              onGenerateRoute: AppRoute.onGenerateRoute,
              initialRoute: SplashPage.routeName,
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            )));
  }
}
