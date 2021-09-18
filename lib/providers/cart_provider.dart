import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _carts = {};

  List<Cart> get getCarts {
    return [..._carts.values];
  }

  int get totalCartItems {
    return _carts.isEmpty ? 0 : _carts.length;
  }

  double get totalSum {
    if (_carts.isEmpty) {
      return 0;
    } else {
      double total = 0;
      _carts.values.forEach((element) {
        total += (element.quantity * element.product.price);
      });
      return total;
    }
  }

  bool existingInCart(id) {
    if (_carts.isNotEmpty) {
      return _carts.containsKey(id);
    } else {
      return false;
    }
  }

  void addToCart(Product product) {
    if (_carts.containsKey(product.id)) {
      _carts.update(
        product.id,
        (value) {
          value.quantity = value.quantity + 1;
          return value;
        },
      );
    } else {
      _carts.putIfAbsent(
          product.id,
          () => Cart(
                product,
                id: product.id,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeFromCart(id) {
    if (_carts.containsKey(id)) {
      _carts.remove(id);
      notifyListeners();
    }
  }

  void clearCart() {
    _carts = {};
    notifyListeners();
  }
}
