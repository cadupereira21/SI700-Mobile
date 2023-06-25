import 'package:app_seu_madeu_sucos/Model/Order.dart';

abstract class OrderMonitorEvent {}

class ListenToSuccesfulCreateOrderRequest extends OrderMonitorEvent {
  Order order;
  ListenToSuccesfulCreateOrderRequest({required this.order});
}

class ListenToFailedCreateOrderRequest extends OrderMonitorEvent {
  String message = "[Order Monitor] Falha na criação do pedido!";
  ListenToFailedCreateOrderRequest();
}
