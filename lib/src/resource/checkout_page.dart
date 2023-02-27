import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/src/widgets/custom_appbar.dart';
import 'package:foodapp/src/widgets/ordersummary_page.dart';

import '../../blocs/checkout/checkout_bloc.dart';
import '../../config/theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/checkout';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CheckoutPage());
  }

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _numberPhone = TextEditingController();
    TextEditingController _address = TextEditingController();

    String errorNumber = '';
    String errorAddress = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: Colors.black,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CheckoutLoaded) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        if (_numberPhone.text.isEmpty) {
                          setState(() {
                            errorNumber = 'Phone is not empty!';
                          });
                        } else if (_numberPhone.text.length > 10 ||
                            _numberPhone.text.length < 10) {
                          setState(() {
                            errorNumber = 'Phone need 10 number!';
                          });
                          print(errorNumber);
                        } else if (_address.text.isEmpty) {
                          setState(() {
                            errorAddress = 'Address is not empty!';
                          });
                        } else {
                          context
                              .read<CheckoutBloc>()
                              .add(ConfirmCheckout(checkout: state.checkout));
                          Future.delayed(Duration.zero, () {
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                Navigator.of(context).pushNamed(
                                  '/order',
                                );
                              },
                            );
                          });
                        }
                      },
                      child: Text(
                        'ORDER NOW',
                        style: theme().textTheme.headline4,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Information',
                            style: theme().textTheme.headline2),
                        _buildTextFormField((value) {
                          context.read<CheckoutBloc>().add(UpdateCheckout(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              numberPhone: value));
                        },
                            _numberPhone,
                            context,
                            'NumberPhone',
                            keybroad: 'phone',
                            errorNumber),
                        _buildTextFormField((value) {
                          context.read<CheckoutBloc>().add(UpdateCheckout(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              address: value));
                        }, _address, context, 'Address', errorAddress),
                      ],
                    ),
                  ),
                  Text(
                    errorAddress.isEmpty ? '' : errorAddress,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const OrderSummaryPage(),
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          },
        ),
      ),
    );
  }

  Container _buildTextFormField(
      Function(String)? onChanged,
      TextEditingController controller,
      BuildContext context,
      String labelText,
      String error,
      {String? keybroad}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            labelText,
            style: theme().textTheme.headline4!.copyWith(color: Colors.black54),
          ),
          Container(
              padding: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width / 1.55,
              child: TextField(
                onChanged: onChanged,
                controller: controller,
                keyboardType: keybroad == 'phone'
                    ? TextInputType.phone
                    : TextInputType.text,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    hintText: error,
                    isDense: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ))
        ],
      ),
    );
  }
}
