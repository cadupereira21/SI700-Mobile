import 'package:app_seu_madeu_sucos/Data/ProductData.dart';
import 'package:app_seu_madeu_sucos/Service/ProductServiceImp.dart';
import 'package:app_seu_madeu_sucos/Service/RequestStatus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/Product.dart';
import 'ProductMonitorEvent.dart';
import 'ProductMonitorState.dart';

class ProductMonitorBloc
    extends Bloc<ProductMonitorEvent, ProductMonitorState> {
  final _serviceStreamController = ProductServiceImp.instance.stream;
  ProductMonitorBloc(super.initialState) {
    _serviceStreamController.listen((event) {
      print("Product Monitor: Recebi um evento - \n${event[0]}");
      switch (event[0]) {
        case ProductServiceImp.REQ_TITLE_GET_PRODUCT:
          _listenToGetAllProducts(event);
          break;
        default:
      }
    });

    on<UpdateProductsEvent>((event, emit) {
      ProductData.instance.addProducts(event.productColletion);
      print(ProductData.instance.allProducts);
      emit(ProductMonitorState(productColletion: event.productColletion));
    });
  }

  void _listenToGetAllProducts(event) {
    RequestStatus responseStatus = event[1];
    List<Product> productColletion = event[2];
    if (responseStatus == RequestStatus.SUCCESSFUL) {
      add(UpdateProductsEvent(productColletion: productColletion));
    }
  }
}
