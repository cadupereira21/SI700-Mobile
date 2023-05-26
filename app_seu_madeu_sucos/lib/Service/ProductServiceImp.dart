import 'package:dio/dio.dart';

import '../Model/Product.dart';
import 'RequestStatus.dart';
import 'Service.dart';

class ProductServiceImp extends Service {
  static const String REQ_TITLE_GET_PRODUCT = "Get User Request";

  static final ProductServiceImp instance = ProductServiceImp._internal();
  ProductServiceImp._internal();

  Future<List<Product>?> getAllProducts() async {
    List<Product> productColletion = [];
    Response<dynamic> response;
    int i = 1;
    while ((response = await dio.get("$baseUrl/products/$i.json")).data != null) {
      Product product = Product(
        id: i.toString(),
        name: response.data["name"],
        description: response.data["description"],
        value: (response.data["value"]).toDouble(),
        planId: response.data["planId"],
      );
      print(product.toString());
      productColletion.add(product);
      i++;
    }
    //Put products on list
    //Notify
    return null;
  }
}
