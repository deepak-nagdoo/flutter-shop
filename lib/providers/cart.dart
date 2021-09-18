import 'package:flutter/cupertino.dart';
import 'package:shop/providers/product.dart';

class Cart with ChangeNotifier {
  final Product product;
  int quantity;
  final String id;

  Cart(
    this.product, {
    required this.id,
    this.quantity = 0,
  });
}
