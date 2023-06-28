import '../../../Model/Product.dart';

class ProductMonitorEvent{}


class ListenToGetAllProductsRequestSuccessful extends ProductMonitorEvent {
  final List<Product> productColletion;
  ListenToGetAllProductsRequestSuccessful({required this.productColletion});
}

class ListenToGetAllProductsRequestFailed extends ProductMonitorEvent {
  String message;
  ListenToGetAllProductsRequestFailed({required this.message});
}