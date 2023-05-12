abstract class CartState {
  List<Map<String, Object>> addedProducts;
  CartState({required this.addedProducts});
}

class AddingToCart extends CartState {
  AddingToCart({required super.addedProducts});
}

class ClearingCart extends CartState {
  ClearingCart({required super.addedProducts});
}
