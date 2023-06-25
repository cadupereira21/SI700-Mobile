abstract class OrderRequesterEvent {}

class CreateOrderRequest extends OrderRequesterEvent {
  CreateOrderRequest();
}

class GetOrderRequest extends OrderRequesterEvent {
  GetOrderRequest();
}
