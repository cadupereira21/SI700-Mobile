import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/CartData.dart';
import 'CartEvent.dart';
import 'CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<AddToCart>((event, emit) {
      CartData.instance.addToCart(event.product);
      emit(AddingToCart(addedProducts: CartData.instance.addedProducts));
    });
    on<ClearCart>((event, emit){
      CartData.instance.clearData();
      emit(ClearingCart(addedProducts: CartData.instance.addedProducts));
    });
    on<RemoveFromCart>((event, emit){
      CartData.instance.removeFromCart(event.product);
      emit(RemovingFromCart(addedProducts: CartData.instance.addedProducts));
    });
  }
}
