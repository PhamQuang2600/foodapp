import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/config/theme.dart';
import 'package:foodapp/src/widgets/custom_bottom.dart';

import '../../blocs/autheticated/authenticated_bloc.dart';
import '../widgets/custom_appbar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  static const String routeName = '/user';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const UserPage());
  }

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var fireAuth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User'),
      bottomNavigationBar: const CustomBottom(),
      body: fireAuth != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  fireAuth!.photoURL == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            fireAuth!.photoURL.toString(),
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Text(
                        'Name',
                        style: theme().textTheme.headline4,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        fireAuth!.displayName.toString(),
                        style: theme().textTheme.headline4,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: theme().textTheme.headline4,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        fireAuth!.email.toString(),
                        style: theme().textTheme.headline4,
                      ),
                    ],
                  ),
                  BlocBuilder<AuthenticatedBloc, AuthenticatedState>(
                    builder: (context, state) {
                      return MaterialButton(
                        color: Colors.black,
                        onPressed: () {
                          context.read<AuthenticatedBloc>().add(SignOutEvent());
                          Future.delayed(
                            Duration.zero,
                            () {
                              AlertDialog alert = AlertDialog(
                                title: Text(
                                  'Do you want sign out?',
                                  style: theme().textTheme.headline4,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthenticatedBloc>()
                                            .add(SignOutEvent());

                                        SnackBar snackBar = const SnackBar(
                                          content: Text('Sign out success!'),
                                          duration: Duration(seconds: 1),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);

                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/sign-in',
                                            (route) => false);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No')),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alert,
                              );
                            },
                          );
                        },
                        child: Text(
                          'Sign out',
                          style: theme()
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      );
                    },
                  )
                ],
              )),
            )
          : Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Sign in continue shopping',
                  style: theme().textTheme.headline4,
                ),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/sign-in', (route) => false);
                    },
                    child: Text(
                      'Sign in',
                      style: theme()
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white),
                    ))
              ]),
            ),
    );
  }
}
