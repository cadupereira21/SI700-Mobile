import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:app_seu_madeu_sucos/Model/Client.dart';
import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';

class Order {
  String? _id;
  Client? _requester;
  List<Map<String, Object>>? _products;
  String? _comments;
  String? _paymentMethod;
  double? _value;
  bool? _isPlan;
  bool? _isDelivery;
  Address? _customDeliveryAddress;

  Order({
    String? id,
    Client? requester,
    List<Map<String, Object>>? products,
    String? comments,
    String? paymentMethod,
    double? value,
    bool? isPlan,
    bool? isDelivery,
    Address? customDeliveryAddress,
  }) {
    _id = id;
    _requester = requester;
    _products = products;
    _comments = comments;
    _paymentMethod = paymentMethod;
    _value = value;
    _isPlan = isPlan;
    _isDelivery = isDelivery;
    _customDeliveryAddress = customDeliveryAddress;
  }

  String? get getId => _id;
  Client? get getRequester => _requester;
  List<Map<String, Object>>? get getProducts => _products;
  String? get getComments => _comments;
  String? get getPaymentMethod => _paymentMethod;
  double? get getValue => _value;
  bool? get getIsPlan => _isPlan;
  bool? get getIsDelivery => _isDelivery;
  Address? get getCustomDeliveryAddress => _customDeliveryAddress;

  set setId(String? id) => _id = id;
  set setRequester(Client? requester) => _requester = requester;
  set setProducts(List<Map<String, Object>>? products) => _products = products;
  set setComments(String? comments) => _comments = comments;
  set setPaymentMethod(String? paymentMethod) =>
      _paymentMethod = paymentMethod;
  set setValue(double? value) => _value = value;
  set setIsPlan(bool? isPlan) => _isPlan = isPlan;
  set setIsDelivery(bool? isDelivery) => _isDelivery = isDelivery;
  set setCustomDeliveryAddress(Address? customDeliveryAddress) =>
      _customDeliveryAddress = customDeliveryAddress;

  @override
  String toString() {
    return "Order: {id: $_id, requester: ${_requester.toString()}, products: ${_products.toString()}, comments: $_comments, paymentMethod: ${_paymentMethod.toString()}, value: $_value, isPlan: $_isPlan, isDelivery: $_isDelivery, customDeliveryAddress: ${_customDeliveryAddress.toString()}}";
  }
}
