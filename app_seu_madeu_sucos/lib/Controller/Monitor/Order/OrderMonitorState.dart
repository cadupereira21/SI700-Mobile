import '../../../Model/Order.dart';

class OrderMonitorState {
  String message = "";
  List<Order> orderCollection = [];
  OrderMonitorState({message, orderCollection}) {
    this.message = message ?? "";
    this.orderCollection = orderCollection ?? [];
  }
}

class OrderRequestSuccesfulState extends OrderMonitorState {
  OrderRequestSuccesfulState(
      {super.message, super.orderCollection});
}

class OrderRequestFailedState extends OrderMonitorState {
  OrderRequestFailedState({super.message, super.orderCollection});
}
