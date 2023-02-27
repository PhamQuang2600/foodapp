import 'package:flutter/material.dart';
import 'package:foodapp/src/widgets/custom_appbar.dart';

import '../../config/theme.dart';

class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage({super.key});

  static const String routeName = '/order';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const OrderConfirmPage());
  }

  @override
  State<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Order'),
        bottomNavigationBar: BottomAppBar(
          height: 60,
          color: Colors.black,
          elevation: 0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Text(
                  'Continue Shopping',
                  style: theme().textTheme.headline3,
                ))
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Image.asset(
                    'assets_image/bubble-gum-shopping-delivery.gif',
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2.8,
                bottom: 10,
                child: Text(
                  'Order Completed',
                  style: theme().textTheme.headline3,
                ),
              ),
            ],
          ),
        ));
  }
}
