import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorState.dart';
import 'package:app_seu_madeu_sucos/Data/CartData.dart';
import 'package:app_seu_madeu_sucos/Data/OrderData.dart';
import 'package:app_seu_madeu_sucos/Service/OrderServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/Order.dart';
import '../../../Service/RequestStatus.dart';

class OrderMonitorBloc extends Bloc<OrderMonitorEvent, OrderMonitorState> {
  final _serviceStreamController = OrderServiceImp.instance.stream;

  OrderMonitorBloc(super.initialState) {
    _serviceStreamController.listen((event) {
      debugPrint("[Order Monitor] Recebi um evento - ${event[0]}");

      switch (event[0]) {
        case OrderServiceImp.REQ_TITLE_CREATE_ORDER:
          _listenToCreateOrder(event);
          break;
        default:
          break;
      }
    });

    on<ListenToSuccesfulCreateOrderRequest>(
      (event, emit) {
        debugPrint("[Order Monitor] Pedido criado com sucesso!");
        OrderData.instance.clearData();
        emit(OrderRequestSuccesfulState(order: event.order));
      },
    );
    on<ListenToFailedCreateOrderRequest>(
      (event, emit) {
        emit(OrderRequestFailedState(message: "[Order Monitor] Não foi possível criar o pedido!"));
      },
    );
  }

  void _listenToCreateOrder(event) {
    RequestStatus responseStatus = event[1];
    String orderId = event[2][0];
    Order order = event[2][1] as Order;
    order.setId = orderId;
    if (responseStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToSuccesfulCreateOrderRequest(order: order));
    } else {
      add(ListenToFailedCreateOrderRequest());
    }
  }
}
