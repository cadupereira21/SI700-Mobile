import '../Model/Product.dart';

class ProductData {
  List<Product> _allProducts = [];

  static final ProductData instance = ProductData._internal();
  ProductData._internal();

  List<Product> get allProducts => List.from(_allProducts);

  void addProducts(List<Product> products) {
    _allProducts.addAll(products);
  }

  void addProduct(Product product) {
    _allProducts.add(product);
  }

  void removeProduct(Product product) {
    _allProducts.remove(product);
  }

  void clearProducts() {
    _allProducts.clear();
  }
}
