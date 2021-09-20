import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/screens/edit_product_details_screen.dart';
import 'package:shop/utils/shop_theme.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: ShopTheme.dynamicWidth(context, 90),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  EditProductDetailsScreen.routeName,
                  arguments: product,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                await Provider.of<ProductProvider>(
                  context,
                  listen: false,
                ).removeProduct(
                  product.id,
                );
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
