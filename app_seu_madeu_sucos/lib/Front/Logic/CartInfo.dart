import '../Entities/Product.dart';

class CartInfo {
  
  static CartInfo instance = CartInfo._createInstance();

  List<Map<String, Object>> _addedProducts = [];
  
    List<Map<String, Object>> get addedProducts => _addedProducts;


  CartInfo._createInstance();

  void addToCart(Product product) {
    int? auxIndex = _productExists(product);
    if (auxIndex == null) {
      _addedProducts.add({'Product': product, 'Quantity': 1});
    } else {
      _addedProducts[auxIndex]
          .update('Quantity', (value) => int.parse(value.toString()) + 1);
    }
    // ignore: avoid_print
    print(
        "Added ${product.toString()} to cart\nQuantidade de produtos adicionados: ${_addedProducts.length.toString()}\n${_addedProducts.toString()}");
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
    // ignore: avoid_print
    print("Removed ${product}from cart\n$_addedProducts");
  }

  int? _productExists(Product product) {
    for (int i = 0; i < _addedProducts.length; i++) {
      if (_addedProducts[i]['Product'] == product) return i;
    }
    return null;
  }

  void clearCart() {
    _addedProducts.clear();
  }

}
