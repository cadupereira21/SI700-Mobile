import '../Interfaces/Product.dart';

class CartInfo {
  static List<Map<String, Object>> addedProducts = [];

  static void addToCart(Product product) {
    int? auxIndex = CartInfo._productExists(product);
    if (auxIndex == null) {
      CartInfo.addedProducts.add({'Product': product, 'Quantity': 1});
    } else {
      CartInfo.addedProducts[auxIndex]
          .update('Quantity', (value) => int.parse(value.toString()) + 1);
    }
    // ignore: avoid_print
    print(
        "Added ${product.toString()} to cart\nQuantidade de produtos adicionados: ${CartInfo.addedProducts.length.toString()}\n${CartInfo.addedProducts.toString()}");
  }

  static void removeFromCart(Product product) {
    for (int i = 0; i < CartInfo.addedProducts.length; i++) {
      if (CartInfo.addedProducts[i]['Products'] == product) {
        if (CartInfo.addedProducts[i]['Quantity'] == 1) {
          CartInfo.addedProducts.removeAt(i);
        } else {
          CartInfo.addedProducts[i].update('Quantity', (value) => int.parse(value.toString()) - 1);
        }
      }
    }
    // ignore: avoid_print
    print("Removed ${product}from cart\n$addedProducts");
  }

  static int? _productExists(Product product) {
    for (int i = 0; i < CartInfo.addedProducts.length; i++) {
      if (CartInfo.addedProducts[i]['Product'] == product) return i;
    }
    return null;
  }
}
