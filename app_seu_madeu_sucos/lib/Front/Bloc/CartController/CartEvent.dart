abstract class CartEvent{
  Product product
  CartEvent({required this.product});
}

class AddToCart extends CartEvent{
  AddToCart({required super.product});
}

class ClearCart extends CartEvent{
  ClearCart({required super.product});
}