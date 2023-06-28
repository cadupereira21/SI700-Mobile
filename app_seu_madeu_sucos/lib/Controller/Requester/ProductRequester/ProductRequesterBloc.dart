import 'package:app_seu_madeu_sucos/Controller/Requester/ProductRequester/ProductRequesterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Service/ProductServiceImp.dart';
import 'ProductRequesterEvent.dart';

class ProductRequesterBloc extends Bloc<ProductRequesterEvent, ProductRequesterState> {
  ProductServiceImp service = ProductServiceImp.instance;
  ProductRequesterBloc(super.initialState) {
    on<CompleteProductRequest>((event, emit){
      emit(WaitingProductRequestState());
    });
    on<GetAllProductsRequest>(
      (event, emit) => _getAllProducts(event, emit),
    );
  }

  _getAllProducts(
      GetAllProductsRequest event, Emitter emit) async {
    emit(ProcessingProductRequestState());
    debugPrint("[Product Requester] Sending get all products request");

    await service.getAllProducts();

    add(CompleteProductRequest());
    debugPrint("[Product Requester] Complete get all products request");
  }
}
