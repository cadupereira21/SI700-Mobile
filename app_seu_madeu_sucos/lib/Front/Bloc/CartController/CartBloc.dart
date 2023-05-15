import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Logic/CartInfo.dart';
import 'CartEvent.dart';
import 'CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<AddToCart>((event, emit) {
      CartInfo.instance.addToCart(event.product);
      emit(AddingToCart(addedProducts: CartInfo.instance.addedProducts));
    });
    on<ClearCart>((event, emit){
      CartInfo.instance.clearCart();
      emit(ClearingCart(addedProducts: CartInfo.instance.addedProducts));
    });
  }
}
