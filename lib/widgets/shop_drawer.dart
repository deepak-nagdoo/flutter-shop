import 'package:flutter/material.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_screen.dart';
import 'package:shop/utils/shop_theme.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({Key? key}) : super(key: key);

  Widget _menuItem(
    BuildContext context,
    title,
    IconData icon,
    VoidCallback action,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      onTap: action,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Center(
              child: Text(
                'Shop All!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            _menuItem(context, 'Home', Icons.star, () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              );
            }),
            _menuItem(context, 'Orders', Icons.add_shopping_cart, () {
              Navigator.of(context).popAndPushNamed(
                OrdersScreen.routeName,
              );
            }),
            _menuItem(context, 'Products', Icons.poll_rounded, () {
              Navigator.of(context).popAndPushNamed(
                ProductScreen.routeName,
              );
            }),
          ],
        ),
      ),
    );
  }
}
