import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/config/theme.dart';

import '../../blocs/autheticated/authenticated_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String routeName = '/splash';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () =>
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
    );
    return BlocListener<AuthenticatedBloc, AuthenticatedState>(
      listener: (context, state) {
        print('Auth Listener');
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://seeklogo.com/images/F/food-logo-59E5A73AFD-seeklogo.com.png',
              height: 150,
              width: 240,
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20),
              child: Text(
                'Food App',
                style:
                    theme().textTheme.headline2!.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
