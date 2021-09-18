import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    List<Cart> carts = provider.getCarts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart!',
        ),
      ),
      body: carts.isEmpty
          ? Center(
              child: Text(
                'Add something to shop!',
                style: Theme.of(context).textTheme.headline1,
              ),
            )
          : Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      Text('Total'),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$${provider.totalSum}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline1!
                                .color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                            carts,
                            provider.totalSum,
                          );
                          provider.clearCart();
                          Navigator.of(context)
                              .pushNamed(OrdersScreen.routeName);
                        },
                        child: Text('Order Now'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      var cart = carts[index];
                      return ChangeNotifierProvider.value(
                        value: cart,
                        builder: (ctx, child) {
                          return CartItem();
                        },
                      );
                    },
                    itemCount: carts.length,
                  ),
                ),
              ],
            ),
    );
  }
}
