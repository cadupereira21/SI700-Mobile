import '../../../Model/Order.dart';

class OrderMonitorState {
  String? message;
  Order? order;
  OrderMonitorState({this.order, this.message});
}

class OrderRequestSuccesfulState extends OrderMonitorState {
  OrderRequestSuccesfulState({super.order, super.message});
}

class OrderRequestFailedState extends OrderMonitorState {
  OrderRequestFailedState({super.order, super.message});
}
