import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:shop/models/httpException.dart';
import 'package:shop/providers/product.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/endpoints.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> _products = [];
  // [
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];

  bool _showFavorites = false;

  bool get showFavorites {
    return _showFavorites;
  }

  void toggleFavorites() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  List<Product> get getProducts {
    return [..._products];
  }

  List<Product> get getFavoriteProducts {
    return [..._products.where((element) => element.isFavorite)];
  }

  Future<void> fetchProducts() async {
    try {
      var response = await http.get(
        Uri.parse(EndPoints[ENDPOINTS.GetProduct]),
      );
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProducts = [];
        extractedData.forEach((prodId, prodData) {
          loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl'],
          ));
        });
        _products = loadedProducts;
        notifyListeners();
      }
    } catch (error) {
      print(json.encode(error.toString()));
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      var response = await http.post(
        Uri.parse(EndPoints[ENDPOINTS.AddProduct]),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      _products.add(product);
      notifyListeners();
      print(response.statusCode);
    } catch (error) {
      print(json.encode(error.toString()));
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      var response = await http.patch(
        Uri.parse(EndPoints[ENDPOINTS.UpdateProduct](product.id)),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      if (response.statusCode < 400) {
        int index = _products.indexWhere((e) => e.id == product.id);
        _products[index] = product;
        notifyListeners();
      } else {
        throw HttpException('Error updating product');
      }
    } catch (error) {
      print(json.encode(error.toString()));
      throw error;
    }
  }

  Future<void> removeProduct(id) async {
    try {
      var response = await http.patch(
        Uri.parse(EndPoints[ENDPOINTS.DeleteProduct](id)),
      );
      if (response.statusCode < 400) {
        _products.removeWhere((e) => e.id == id);
        notifyListeners();
      } else {
        throw HttpException('Error updating product');
      }
    } catch (error) {
      print(json.encode(error.toString()));
      throw error;
    }
  }
}
