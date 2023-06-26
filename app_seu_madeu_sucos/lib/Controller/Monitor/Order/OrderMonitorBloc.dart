import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorState.dart';
import 'package:app_seu_madeu_sucos/Data/CartData.dart';
import 'package:app_seu_madeu_sucos/Data/NewOrderData.dart';
import 'package:app_seu_madeu_sucos/Data/OrderCollectionData.dart';
import 'package:app_seu_madeu_sucos/Service/OrderServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/Order.dart';
import '../../../Service/RequestStatus.dart';

class OrderMonitorBloc extends Bloc<OrderMonitorEvent, OrderMonitorState> {
  final _serviceStreamController = OrderServiceImp.instance.stream;
  final _orderCollectionData = OrderCollectionData.instance;

  OrderMonitorBloc(super.initialState) {
    _serviceStreamController.listen((event) {
      debugPrint("[Order Monitor] Recebi um evento - ${event[0]}");

      switch (event[0]) {
        case OrderServiceImp.REQ_TITLE_CREATE_ORDER:
          _listenToCreateOrder(event);
          break;
        case OrderServiceImp.REQ_TITLE_GET_ALL_ORDERS:
          _listenToGetAllOrders(event);
          break;
        default:
          break;
      }
    });

    on<ListenToSuccesfulCreateOrderRequest>(
      (event, emit) {
        debugPrint("[Order Monitor] Pedido criado com sucesso!");
        NewOrderData.instance.clearData();
        _orderCollectionData.addOrder(event.order);
        emit(OrderRequestSuccesfulState(
            orderCollection: _orderCollectionData.getAllOrders));
      },
    );
    on<ListenToFailedCreateOrderRequest>(
      (event, emit) {
        debugPrint("[Order Monitor] Criação de pedido falhou");
        emit(OrderRequestFailedState(
            message: "Não foi possível criar o pedido!"));
      },
    );
    on<ListenToSuccesfulGetAllOrdersRequest>(
      (event, emit) {
        debugPrint("[Order Monitor] Busca por pedidos sucedida");
        _orderCollectionData.addOrders(event.orderCollection);
        emit(OrderRequestSuccesfulState(
            orderCollection: _orderCollectionData.getAllOrders));
      },
    );
    on<ListenToFailedGetAllOrdersRequest>(
      (event, emit) {
        debugPrint("[Order Monitor] Busca por pedidos falhou");
        emit(OrderRequestFailedState(
            message: "Não foi possível buscar os pedidos!"));
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

  void _listenToGetAllOrders(event) {
    RequestStatus responseStatus = event[1];
    List<Order> orderCollection = event[2] as List<Order>;
    if (responseStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToSuccesfulGetAllOrdersRequest(
          orderCollection: orderCollection));
    } else {
      add(ListenToFailedGetAllOrdersRequest());
    }
  }
}
