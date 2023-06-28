import 'dart:async';

import 'package:app_seu_madeu_sucos/Service/Service.dart';
import 'package:dio/dio.dart';

import '../Model/Product.dart';
import 'RequestStatus.dart';

class ProductServiceImp extends Service {
  static const String REQ_TITLE_GET_PRODUCT = "Get User Request";

  static final ProductServiceImp instance = ProductServiceImp._internal();
  ProductServiceImp._internal();

  Future<void> getAllProducts() async {
    List<Product> productColletion = [];
    Response<dynamic> response;
    int i = 1;
    while (
        (response = await dio.get("$baseUrl/products/$i.json")).data != null) {
      Product product = Product(
        id: i.toString(),
        name: response.data["name"],
        description: response.data["description"],
        value: (response.data["value"]).toDouble(),
        planId: response.data["planId"],
      );

      productColletion.add(product);
      i++;
    }

    notify(
      requestTitle: REQ_TITLE_GET_PRODUCT, 
      responseStatus: RequestStatus.SUCCESSFUL, 
      object: productColletion,
    );
  }
}
