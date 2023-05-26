import '../Model/Product.dart';

class ProductData {
  static final List<Product> _allProducts = [];

  static List<Product> get allProducts => List.from(_allProducts);
}
