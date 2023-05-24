import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../CartController.dart';
import 'CartEvent.dart';
import 'CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<AddToCart>((event, emit) {
      CartController.instance.addToCart(event.product);
      emit(AddingToCart(addedProducts: CartController.instance.addedProducts));
    });
    on<ClearCart>((event, emit){
      CartController.instance.clearCart();
      emit(ClearingCart(addedProducts: CartController.instance.addedProducts));
    });
    on<RemoveFromCart>((event, emit){
      CartController.instance.removeFromCart(event.product);
      emit(RemovingFromCart(addedProducts: CartController.instance.addedProducts));
    });
  }
}
