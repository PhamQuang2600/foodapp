import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/autheticated/authenticated_bloc.dart';
import '../../config/theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String routeName = '/sign-in';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SignInPage(),
    );
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  bool isShowPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://seeklogo.com/images/F/food-logo-59E5A73AFD-seeklogo.com.png',
              height: 200,
              width: 200,
            ),
            Text(
              'Thank you for using our service',
              style: theme().textTheme.headline3,
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: MaterialButton(
                padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
                height: 50,
                color: Colors.blueAccent,
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    context.read<AuthenticatedBloc>().add(GoogleSignInEvent());

                    Future.delayed(const Duration(seconds: 10), () {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.popAndPushNamed(context, '/');
                      });

                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          try {
                            ScaffoldMessenger.of(_scaffold.currentContext!)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Sign in succes!',
                                style: TextStyle(fontSize: 18),
                              ),
                              duration: Duration(seconds: 2),
                            ));
                          } catch (e) {
                            print(e);
                          }
                        },
                      );
                    });
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 50,
                      width: 50,
                      child: Image.network(
                        'https://img.icons8.com/color/256/google-logo.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Text(
                      'Sign In with Google',
                      style: theme()
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
