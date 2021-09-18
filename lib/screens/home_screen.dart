import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/filters.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:shop/widgets/shop_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    List<Product> products = provider.showFavorites
        ? provider.getFavoriteProducts
        : provider.getProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop All!',
        ),
        actions: [
          Badge(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: '${cartProvider.totalCartItems}'),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: Filters.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: Filters.All,
                ),
              ];
            },
            onSelected: (type) {
              if (type == Filters.Favorites && !provider.showFavorites) {
                provider.toggleFavorites();
              } else if (type == Filters.All && provider.showFavorites) {
                provider.toggleFavorites();
              }
            },
          )
        ],
      ),
      drawer: const ShopDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(
              key: ValueKey(
                products[index].id,
              ),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
