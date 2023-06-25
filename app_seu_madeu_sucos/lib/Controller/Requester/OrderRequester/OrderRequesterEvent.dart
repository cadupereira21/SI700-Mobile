import 'package:app_seu_madeu_sucos/Model/Order.dart';

abstract class OrderRequesterEvent {}

class CompleteOrderRequest extends OrderRequesterEvent {
  CompleteOrderRequest();
}

class CreateOrderRequest extends OrderRequesterEvent {
  Order order;
  CreateOrderRequest({required this.order});
}

class GetOrderRequest extends OrderRequesterEvent {
  GetOrderRequest();
}
