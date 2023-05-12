import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Logic/CartInfo.dart';
import 'CartEvent.dart';
import 'CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<AddToCart>((event, emit) {
      CartInfo.addToCart(event.product);
      emit(AddingToCart(addedProducts: CartInfo.addedProducts));
    });
    on<ClearCart>((event, emit){
      CartInfo.clearCart();
      emit(ClearingCart(addedProducts: CartInfo.addedProducts));
    });
  }
}
