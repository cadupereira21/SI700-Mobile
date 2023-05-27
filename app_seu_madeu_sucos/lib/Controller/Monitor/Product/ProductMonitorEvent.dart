import '../../../Model/Product.dart';

class ProductMonitorEvent{}

class UpdateProductsEvent extends ProductMonitorEvent{
  final List<Product> productColletion;
  UpdateProductsEvent({required this.productColletion});
}