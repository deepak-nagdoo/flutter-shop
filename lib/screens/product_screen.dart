import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product All!',
        ),
      ),
      body: const Center(
        child: Text(
          'Product page!',
        ),
      ),
    );
  }
}
