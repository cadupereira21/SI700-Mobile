import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/UserData.dart';
import '../../../Service/OrderServiceImp.dart';

class OrderRequesterBloc
    extends Bloc<OrderRequesterEvent, OrderRequesterState> {
  var service = OrderServiceImp.instance;

  OrderRequesterBloc(super.initialState) {
    on<CompleteOrderRequest>(
      (event, emit) {
        emit(WaitingOrderRequestState());
      },
    );
    on<CreateOrderRequest>(
      (event, emit) {
        _createOrderRequest(event, emit);
      },
    );
    on<GetAllOrdersRequest>(
      (event, emit) {
        _getAllOrdersRequest(event, emit);
      },
    );
  }

  Future<void> _createOrderRequest(
      CreateOrderRequest event, Emitter emit) async {
    emit(ProcessingOrderRequestState());

    await service.createOrder(event.order);

    add(CompleteOrderRequest());
  }

  void _getAllOrdersRequest(
      GetAllOrdersRequest event, Emitter<OrderRequesterState> emit) async {
    emit(ProcessingOrderRequestState());
    debugPrint("[Order Requester] Enviando GetAllOrdersRequest");

    await service.getOrdersByUserEmail(UserData.instance.user);

    add(CompleteOrderRequest());
    debugPrint("[Order Requester] GetAllOrdersRequest completada");
  }
}
