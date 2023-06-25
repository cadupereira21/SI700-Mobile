import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderRequesterBloc
    extends Bloc<OrderRequesterEvent, OrderRequesterState> {

  //var service = OrderServiceImp.instance;

  OrderRequesterBloc(super.initialState) {
    on<CreateOrderRequest>(
      (event, emit) {
        _createOrderRequest(event, emit);
      },
    );
  }
  
  void _createOrderRequest(OrderRequesterEvent event, Emitter emit) {
    emit(ProcessingOrderRequestState());

    //Send request to service

    // try {
    //   await service.createOrder();
    //   emit(SuccessfulOrderRequestState(message: "Produtos encontrados com sucesso!"));
    //   print((state as SuccessfulOrderRequestState).message);
    // } catch (e) {
    //   emit(FailedOrderRequestState(message: e.toString()));
    //   print(e.toString());
    // }
  }
}
