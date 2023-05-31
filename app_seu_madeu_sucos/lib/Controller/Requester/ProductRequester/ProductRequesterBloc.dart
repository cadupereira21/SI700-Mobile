import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Service/ProductServiceImp.dart';
import '../RequestState.dart';
import 'ProductRequesterEvent.dart';

class ProductRequesterBloc extends Bloc<ProductRequesterEvent, RequestState> {
  ProductServiceImp service = ProductServiceImp.instance;
  ProductRequesterBloc(super.initialState) {
    on<GetAllProductsRequest>(
      (event, emit) => _getAllProducts(event, emit),
    );
  }

  _getAllProducts(
      GetAllProductsRequest event, Emitter<RequestState> emit) async {
    emit(ProcessingRequest());

    try {
      await service.getAllProducts();
      emit(RequestSuccess(message: "Produtos encontrados com sucesso!"));
      print((state as RequestSuccess).message);
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
      print(e.toString());
    }
  }
}
