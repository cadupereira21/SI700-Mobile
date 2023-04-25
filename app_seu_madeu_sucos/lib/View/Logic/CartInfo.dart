import '../Interfaces/Product.dart';

class CartInfo {
  static List<Product> _addedProducts = [];

  static void addToCart(Product product) {
    CartInfo._addedProducts.add(product);
    print("Added " + product.toString() + "to cart\n" + _addedProducts.toString());
  }

  static void removeFromCart(Product product) {
    CartInfo._addedProducts.remove(product);
    print("Removed " + product.toString() + "from cart\n" + _addedProducts.toString());
  }
}
