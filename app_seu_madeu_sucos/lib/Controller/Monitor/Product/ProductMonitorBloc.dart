import 'package:app_seu_madeu_sucos/Data/ProductData.dart';
import 'package:app_seu_madeu_sucos/Service/ProductServiceImp.dart';
import 'package:app_seu_madeu_sucos/Service/RequestStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/Product.dart';
import 'ProductMonitorEvent.dart';
import 'ProductMonitorState.dart';

class ProductMonitorBloc
    extends Bloc<ProductMonitorEvent, ProductMonitorState> {
  final _serviceStreamController = ProductServiceImp.instance.stream;
  ProductMonitorBloc(super.initialState) {
    _serviceStreamController.listen((event) {
      debugPrint("[product-monitor] Received an event: ${event[0]}");
      switch (event[0]) {
        case ProductServiceImp.REQ_TITLE_GET_PRODUCT:
          _listenToGetAllProducts(event);
          break;
        default:
      }
    });

    on<ListenToGetAllProductsRequestSuccessful>((event, emit) {
      debugPrint("[product-monitor] Get all products request successful");
      ProductData.instance.addProducts(event.productColletion);
      emit(ProductRequestSuccesfulState(productColletion: event.productColletion));
    });

    on<ListenToGetAllProductsRequestFailed>((event, emit) {
      debugPrint("[product-monitor] Get all products request failed");
      emit(ProductRequestFailedState(message: event.message));
    },);
  }

  void _listenToGetAllProducts(event) {
    RequestStatus responseStatus = event[1];
    List<Product> productColletion = event[2];
    if (responseStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToGetAllProductsRequestSuccessful(productColletion: productColletion));
    } else {
      add(ListenToGetAllProductsRequestFailed(message: "Falha na obtenção dos produtos"));
    }
  }
}
