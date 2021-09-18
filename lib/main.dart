import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:shop/screens/product_screen.dart';
import 'package:shop/utils/shop_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop All',
        theme: ShopTheme.main(context),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          ProductScreen.routeName: (ctx) => const ProductScreen(),
          ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
        },
      ),
    );
  }
}
