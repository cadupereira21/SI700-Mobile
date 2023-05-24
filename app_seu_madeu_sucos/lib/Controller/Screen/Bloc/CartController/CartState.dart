class CartState {
  List<Map<String, Object>> addedProducts;
  CartState({this.addedProducts = const []});
}

class AddingToCart extends CartState {
  AddingToCart({required super.addedProducts});
}

class RemovingFromCart extends CartState {
  RemovingFromCart({required super.addedProducts});
}

class ClearingCart extends CartState {
  ClearingCart({required super.addedProducts});
}
