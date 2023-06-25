import 'package:app_seu_madeu_sucos/Model/Order.dart';

abstract class OrderMonitorEvent {}

class UpdateOrdersEvent extends OrderMonitorEvent{
  Order order;
  UpdateOrdersEvent({required this.order});
}
