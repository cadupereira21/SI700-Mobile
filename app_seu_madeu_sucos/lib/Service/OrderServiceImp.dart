import 'dart:convert';

import 'package:app_seu_madeu_sucos/Model/Product.dart';
import 'package:app_seu_madeu_sucos/Service/Service.dart';
import 'package:flutter/material.dart';

import '../Model/Order.dart';
import 'RequestStatus.dart';

class OrderServiceImp extends Service {
  static final OrderServiceImp instance = OrderServiceImp._internal();

  static const REQ_TITLE_CREATE_ORDER = "Create Order Request";

  OrderServiceImp._internal();

  Future<void> createOrder(Order order) async {
    // for (int i = 0; i < order.getProducts!.length; i++) {
    //   Product product = order.getProducts![i]["Product"] as Product;
    //   int quantity = int.parse(order.getProducts![i]["Quantity"].toString());

    //   products.add(json.encode({
    //     "product": product.getName,
    //     "quantity": quantity,
    //   }));
    // }

    final createOrderResponse = await dio.post(
      "$baseUrl/orders.json",
      data: json.encode({
        "requester": {
          "user": {
            "email": order.getRequester!.getEmail,
            "client": {
              "name": order.getRequester!.getClient!.getName,
            },
          },
        },
        "comments": order.getComments,
        "paymentMethod": order.getPaymentMethod,
        "value": order.getValue,
        "isPlan": order.getIsPlan,
        "isDelivery": order.getIsDelivery,
        "customDeliveryAddress": order.getCustomDeliveryAddress ?? "",
        "deliveryTime": order.getDeliveryTime ?? "",
        "takeAwayTime": order.getTakeAwayTime ?? "",
      }),
    );

    for (int i = 0; i < order.getProducts!.length; i++) {
      Product product = order.getProducts![i]['Product'] as Product;
      int quantity = int.parse(order.getProducts![i]['Quantity'].toString());
      final createOrderProductResponse = await dio.post(
        "$baseUrl/orders/${createOrderResponse.data['name'].toString()}/products.json",
        data: json.encode({
          "product": product.getName,
          "quantity": quantity,
        }),
      );

      if (createOrderResponse.statusCode!.toInt() / 100 != 2) {
        notify(
          requestTitle: OrderServiceImp.REQ_TITLE_CREATE_ORDER,
          responseStatus: RequestStatus.FAILED,
          object: [],
        );
      }
    }

    notify(
      requestTitle: OrderServiceImp.REQ_TITLE_CREATE_ORDER,
      responseStatus: createOrderResponse.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [createOrderResponse.data['name'].toString(), order],
    );
  }
}
