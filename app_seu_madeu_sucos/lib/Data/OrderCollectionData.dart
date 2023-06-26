import '../Model/Order.dart';

class OrderCollectionData {
  final List<Order> _allOrders = [];

  static final OrderCollectionData instance = OrderCollectionData._internal();
  OrderCollectionData._internal();

  List<Order> get getAllOrders => List.from(_allOrders);

  void addOrders(List<Order> orders) {
    _allOrders.addAll(orders);
  }

  void addOrder(Order order) {
    _allOrders.add(order);
  }

  void removeOrder(Order order) {
    _allOrders.remove(order);
  }

  void clearOrders() {
    _allOrders.clear();
  }
}
