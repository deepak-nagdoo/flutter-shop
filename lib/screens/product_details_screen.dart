import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
        ),
      ),
      body: const Center(
        child: Text(
          'Product Detail page!',
        ),
      ),
    );
  }
}
