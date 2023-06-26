import '../../../Model/Order.dart';

class OrderMonitorState {
  String? message;
  Order? order;
  List<Order>? orderCollection;
  OrderMonitorState({this.order, this.message, this.orderCollection});
}

class OrderRequestSuccesfulState extends OrderMonitorState {
  OrderRequestSuccesfulState({super.order, super.message, super.orderCollection});
}

class OrderRequestFailedState extends OrderMonitorState {
  OrderRequestFailedState({super.order, super.message, super.orderCollection});
}
