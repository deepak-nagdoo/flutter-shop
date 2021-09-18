import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:shop/utils/shop_theme.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    var cartProvider = Provider.of<CartProvider>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: GridTile(
        child: Card(
          elevation: 5,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: product,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                print(exception.toString());
                return const Text('😢');
              },
              width: ShopTheme.dynamicWidth(
                context,
                120,
              ),
            ),
          ),
        ),
        footer: Consumer<Product>(
          child: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          builder: (ctx, product, child) => GridTileBar(
            title: child,
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                product.isFavrouite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                product.toggleFavrouite();
              },
            ),
            trailing: IconButton(
              icon: Icon(
                cartProvider.existingInCart(product.id)
                    ? Icons.remove_shopping_cart
                    : Icons.add_shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                if (cartProvider.existingInCart(product.id)) {
                  cartProvider.removeFromCart(product.id);
                } else {
                  cartProvider.addToCart(
                    product,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
