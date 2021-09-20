import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/screens/edit_product_details_screen.dart';
import 'package:shop/widgets/user_product_item.dart';

class ManageProductScreen extends StatefulWidget {
  static const routeName = '/product';

  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  @override
  Widget build(BuildContext context) {
    var allProducts = Provider.of<ProductProvider>(context).getProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Products!',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditProductDetailsScreen.routeName,
                arguments: null,
              );
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<ProductProvider>(context, listen: false)
              .fetchProducts();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (ctx, i) {
              return Column(children: [
                ChangeNotifierProvider.value(
                  value: allProducts[i],
                  builder: (ctx, child) {
                    return UserProductItem(
                      key: ValueKey(
                        allProducts[i].id,
                      ),
                    );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                )
              ]);
            },
          ),
        ),
      ),
    );
  }
}
