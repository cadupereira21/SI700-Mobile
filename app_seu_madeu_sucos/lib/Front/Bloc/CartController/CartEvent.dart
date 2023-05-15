import '../../Entities/Product.dart';

abstract class CartEvent {
  CartEvent();
}

class AddToCart extends CartEvent {
  Product product;
  AddToCart({required this.product});
}

class RemoveFromCart extends CartEvent {
  Product product;
  RemoveFromCart({required this.product});
}

class ClearCart extends CartEvent {
  ClearCart();
}
