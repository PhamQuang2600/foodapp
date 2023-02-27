import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/products.dart';
import 'package:foodapp/src/widgets/custom_appbar.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../widgets/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = '/search';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SearchPage());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Search'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    top: 10, left: 30, right: 30, bottom: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search anything for you need',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height - 140,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs
                                  .map((e) => Product.productSnapshot(e));

                              if (name.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/product',
                                        arguments: data);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1,
                                          height: 200,
                                          child: Image.network(
                                            data.elementAt(index).image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 120,
                                          left: 0,
                                          right: 0,
                                          bottom: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withAlpha(200)),
                                            height: 70,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        data
                                                            .elementAt(index)
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 10),
                                                      child: Text(
                                                        '\$${data.elementAt(index).price}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                firebaseAuth.currentUser != null
                                                    ? BlocBuilder<CartBloc,
                                                        CartState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is CartLoading) {
                                                            return const CircularProgressIndicator(
                                                              color:
                                                                  Colors.black,
                                                            );
                                                          } else if (state
                                                              is CartLoaded) {
                                                            return IconButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          CartBloc>()
                                                                      .add(AddCartEvent(
                                                                          data.elementAt(
                                                                              index)));

                                                                  SnackBar snackBar = const SnackBar(
                                                                      content: Text(
                                                                          'Added to your Cart!'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1));
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .add_circle,
                                                                  color: Colors
                                                                      .white,
                                                                ));
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                  'Something went wrong!'),
                                                            );
                                                          }
                                                        },
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          SnackBar snackBar =
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Sign in to add cart!'),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        },
                                                        icon: const Icon(
                                                          Icons.add_circle,
                                                          color: Colors.white,
                                                        )),
                                                const SizedBox()
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }

                              if (data
                                  .elementAt(index)
                                  .name
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return ProductCard(
                                  product: data.elementAt(index),
                                  widthFactory: 1,
                                );
                              }
                            },
                          ),
                        );
                },
              )
            ],
          ),
        ));
  }
}
