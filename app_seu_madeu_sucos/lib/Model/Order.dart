import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:app_seu_madeu_sucos/Model/Client.dart';
import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';

class Order {
  String? id;
  Client? requester;
  List<Map<String, Object>>? products;
  String? comments;
  PaymentMethod? paymentMethod;
  double? value;
  bool? isPlan;
  bool? isDelivery;
  Address? customDeliveryAddress;

  Order({
    this.id,
    this.requester,
    this.products,
    this.comments,
    this.paymentMethod,
    this.value,
    this.isPlan,
    this.isDelivery,
    this.customDeliveryAddress,
  });

  String? get getId => this.id;
  Client? get getRequester => this.requester;
  List<Map<String, Object>>? get getProducts => this.products;
  String? get getComments => this.comments;
  PaymentMethod? get getPaymentMethod => this.paymentMethod;
  double? get getValue => this.value;
  bool? get getIsPlan => this.isPlan;
  bool? get getIsDelivery => this.isDelivery;
  Address? get getCustomDeliveryAddress => this.customDeliveryAddress;

  set setId(String? id) => this.id = id;
  set setRequester(Client? requester) => this.requester = requester;
  set setProducts(List<Map<String, Object>>? products) =>
      this.products = products;
  set setComments(String? comments) => this.comments = comments;
  set setPaymentMethod(PaymentMethod? paymentMethod) =>
      this.paymentMethod = paymentMethod;
  set setValue(double? value) => this.value = value;
  set setIsPlan(bool? isPlan) => this.isPlan = isPlan;
  set setIsDelivery(bool? isDelivery) => this.isDelivery = isDelivery;
  set setCustomDeliveryAddress(Address? customDeliveryAddress) =>
      this.customDeliveryAddress = customDeliveryAddress;

  @override
  String toString() {
    return "Order: {id: $id, requester: ${requester.toString()}, products: ${products.toString()}, comments: $comments, paymentMethod: ${paymentMethod.toString()}, value: $value, isPlan: $isPlan, isDelivery: $isDelivery, customDeliveryAddress: ${customDeliveryAddress.toString()}}";
  }
}
