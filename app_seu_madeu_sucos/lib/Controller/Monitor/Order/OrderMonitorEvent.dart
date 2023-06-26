import 'package:app_seu_madeu_sucos/Model/Order.dart';

abstract class OrderMonitorEvent {}

class ListenToSuccesfulCreateOrderRequest extends OrderMonitorEvent {
  Order order;
  ListenToSuccesfulCreateOrderRequest({required this.order});
}

class ListenToFailedCreateOrderRequest extends OrderMonitorEvent {
  String message = "Falha na criação do pedido!";
  ListenToFailedCreateOrderRequest();
}

class ListenToSuccesfulGetAllOrdersRequest extends OrderMonitorEvent {
  List<Order> orderCollection;
  ListenToSuccesfulGetAllOrdersRequest({required this.orderCollection});
}

class ListenToFailedGetAllOrdersRequest extends OrderMonitorEvent {
  String message = "Falha na busca por pedidos";
  ListenToFailedGetAllOrdersRequest();
}
