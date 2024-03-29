
import 'package:app_seu_madeu_sucos/Service/Service.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../Model/Address.dart';
import '../Model/Order.dart';
import '../Model/Product.dart';
import '../Model/UserModel.dart';
import 'RequestStatus.dart';

class OrderServiceImp extends Service {
  static final OrderServiceImp instance = OrderServiceImp._internal();

  static const REQ_TITLE_CREATE_ORDER = "Create Order Request";

  static const REQ_TITLE_GET_ALL_ORDERS = "Get All Order Request";

  OrderServiceImp._internal();

  Future<void> sendWhatsappOrderMessage(Order order) async {
    debugPrint("[order-service] starting to send whatsapp message");

    try{
      const link = WhatsAppUnilink(
        phoneNumber: '+55-(19)996060222',
        text: "Hey! I'm inquiring about the apartment listing",
      );
      if(await canLaunchUrl(Uri.parse(link.toString()))){
        await launchUrl(Uri.parse(link.toString()));
      } else {
        throw 'Não é possível enviar a mensagem!';
      }
    } catch (e) {
      debugPrint("[order-service] whatsapp send message error: ${e.toString()}");
    }
  }

  Future<void> createOrder(Order order) async {
    final orderId = const Uuid().v1();

    final createOrderResponse = await dio.post(
      "$baseUrl/orders/${orderId}.json",
      data: order.toMap(),
    );

    order.setId = orderId;
    _transformOrderModelProductList(order);

    //sendWhatsappOrderMessage(order); currently not working

    notify(
      requestTitle: OrderServiceImp.REQ_TITLE_CREATE_ORDER,
      responseStatus: createOrderResponse.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [orderId, order],
    );
  }

  Future<Response> getAllOrders() async {
    final response = await dio.get("$baseUrl/orders.json");

    return response;
  }

  Future<void> getOrdersByUserEmail(UserModel user) async {
    var getAllOrdersResponse = await getAllOrders();

    if (getAllOrdersResponse.statusCode!.toInt() / 100 != 2) {
      notify(
        requestTitle: OrderServiceImp.REQ_TITLE_GET_ALL_ORDERS,
        responseStatus: RequestStatus.FAILED,
        object: [],
      );
    }

    notify(
      requestTitle: OrderServiceImp.REQ_TITLE_GET_ALL_ORDERS,
      responseStatus: RequestStatus.SUCCESSFUL,
      object: _filterOrders(user, getAllOrdersResponse.data),
    );
  }

  List<Order> _filterOrders(UserModel user, Map<String, dynamic> firebaseOrderMap) {
    debugPrint(
        "[order-service] Begin to filter orders by user email \"${user.getEmail}\"");
    List<Order> filteredOrders = [];
    var firebaseOrderMapKeys = firebaseOrderMap.keys;
    var firebaseOrderMapValues = firebaseOrderMap.values;
    var index = 0;
    firebaseOrderMapValues.forEach((element) {
      var order = (element as Map<String, dynamic>).values;
      order.forEach((element) {
        if (element['requester']['user']['email'].toString() == user.getEmail) {
          filteredOrders.add(_buildOrderFromFirebaseOrderModel(
            firebaseOrderMapKeys.elementAt(index).split("-")[0].toUpperCase(),
            element,
            user,
          ));
        }
        index++;
      });
    });
    debugPrint(
        "[order-service] Finished filtering, there are ${filteredOrders.length} orders returned: ${filteredOrders.toString()}");

    return filteredOrders;
  }

  Order _buildOrderFromFirebaseOrderModel(elementId, element, user) {
    Order orderModel = Order();

    if (element['customDeliveryAddress'] != null) {
      orderModel.setCustomDeliveryAddress =
          _buildAddressFromFirebaseOrderCustomDeliveryAddressModel(element);
    }

    orderModel.setId = elementId;
    orderModel.setRequester = user;
    orderModel.setProducts =
        _buildProductsListFromFirebaseOrderProductsModel(element);
    orderModel.setComments = element['comments'].toString();
    orderModel.setDeliveryTime = element['deliveryTime'].toString();
    orderModel.setIsDelivery = element['isDelivery'] as bool;
    orderModel.setIsPlan = element['isPlan'] as bool;
    orderModel.setPaymentMethod = element['paymentMethod'].toString();
    orderModel.setTakeAwayTime = element['takeAwayTime'].toString();
    orderModel.setValue = double.parse(element['value'].toString());

    return orderModel;
  }

  Address? _buildAddressFromFirebaseOrderCustomDeliveryAddressModel(element) {
    Address addressModel = Address();
    var addressAuxMap =
        (element['customDeliveryAddress'] as Map<String, dynamic>);
    addressModel.setStreet = addressAuxMap['street'].toString();
    addressModel.setStreetNumber =
        int.parse(addressAuxMap['streetNumber'].toString());
    addressModel.setNeighbour = addressAuxMap['neighbour'].toString();
    addressModel.setDistrict = addressAuxMap['district'].toString();
    addressModel.setCity = addressAuxMap['city'].toString();
    addressModel.setCep = addressAuxMap['cep'].toString();
    return addressModel;
  }

  List<Map<String, Object>>? _buildProductsListFromFirebaseOrderProductsModel(
      element) {
    List<Map<String, Object>> products = [];
    var productsAuxMap = (element['products'] as Map<String, dynamic>).values;
    productsAuxMap.forEach((element) {
      products.add({
        'Product': element['product'],
        'Quantity': element['quantity'],
      });
    });
    return products;
  }
  
  void _transformOrderModelProductList(Order order) {
    List<Map<String, Object>> newOrderProductsModel = [];
    var orderProducts = order.getProducts!;
    orderProducts.forEach(
      (element) {
        newOrderProductsModel.add({
          "Product":(element['Product'] as Product).getName!,
          "Quantity": int.parse(element['Quantity']!.toString()),  
        });
      },
    );

    order.setProducts = newOrderProductsModel;
  }
}
