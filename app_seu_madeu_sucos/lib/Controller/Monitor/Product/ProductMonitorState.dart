import 'package:app_seu_madeu_sucos/Model/Product.dart';

class ProductMonitorState{
  String? message;
  ProductMonitorState({this.message});
}

class ProductRequestSuccesfulState extends ProductMonitorState {
  List<Product> productColletion;
  ProductRequestSuccesfulState(
      {super.message, required this.productColletion});
}

class ProductRequestFailedState extends ProductMonitorState {
  ProductRequestFailedState({super.message});
}