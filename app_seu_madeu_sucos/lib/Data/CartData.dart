import 'package:flutter/material.dart';

import '../Model/Product.dart';

class CartData {
  static CartData instance = CartData._createInstance();

  // _addedProducts: [
  //   {
  //      "Product" : Product,
  //      "Quantity" : int,
  //   }
  // ]
  List<Map<String, Object>> _addedProducts = [];

  List<Map<String, Object>> get addedProducts => List.from(_addedProducts);

  CartData._createInstance();

  void addToCart(Product product) {
    int? auxIndex = _productExists(product);
    if (auxIndex == null) {
      _addedProducts.add({'Product': product, 'Quantity': 1});
    } else {
      _addedProducts[auxIndex]
          .update('Quantity', (value) => int.parse(value.toString()) + 1);
    }
    debugPrint(
        "[Cart Data] Added ${product.name.toString()} to cart");
  }

  void removeFromCart(Product product) {
    for (int i = 0; i < _addedProducts.length; i++) {
      Product? p = _addedProducts[i]['Product'] as Product;
      int quantity = _addedProducts[i]['Quantity'] as int;
      if (p == product) {
        if (quantity == 1) {
          _addedProducts.removeAt(i);
        } else {
          _addedProducts[i]
              .update('Quantity', (value) => int.parse(value.toString()) - 1);
        }
      }
    }
    
    debugPrint("[Cart Data] Removed ${product}from cart");
  }

  int? _productExists(Product product) {
    for (int i = 0; i < _addedProducts.length; i++) {
      if (_addedProducts[i]['Product'] == product) return i;
    }
    return null;
  }

  void clearData() {
    _addedProducts.clear();
  }

  double get getTotalValue {
    double totalValue = 0.0;
    for (int i = 0; i < _addedProducts.length; i++) {
      Product product = (_addedProducts[i]['Product'] as Product);
      totalValue += product.getValue!.toDouble();
    }
    return totalValue;
  }
}
