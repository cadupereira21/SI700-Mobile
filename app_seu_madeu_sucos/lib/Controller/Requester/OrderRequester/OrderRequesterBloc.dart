import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  Future<void> _createOrderRequest(
      CreateOrderRequest event, Emitter emit) async {
    emit(ProcessingOrderRequestState());

    await service.createOrder(event.order);

    add(CompleteOrderRequest());
  }
}
