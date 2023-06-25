import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:app_seu_madeu_sucos/Model/Product.dart';
import 'package:app_seu_madeu_sucos/Model/User.dart';

class Order {
  String? _id;
  User? _requester;
  List<Map<String, Object>>? _products;
  String? _comments;
  String? _paymentMethod;
  double? _value;
  bool? _isPlan;
  bool? _isDelivery;
  Address? _customDeliveryAddress;
  String? _deliveryTime;
  String? _takeAwayTime;

  Order({
    String? id,
    User? requester,
    List<Map<String, Object>>? products,
    String? comments,
    String? paymentMethod,
    double? value,
    bool? isPlan,
    bool? isDelivery,
    Address? customDeliveryAddress,
    String? deliveryTime,
    String? takeAwayTime,
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
    _deliveryTime = deliveryTime;
    _takeAwayTime = takeAwayTime;
  }

  String? get getId => _id;
  User? get getRequester => _requester;
  List<Map<String, Object>>? get getProducts => _products;
  String? get getComments => _comments;
  String? get getPaymentMethod => _paymentMethod;
  double? get getValue => _value;
  bool? get getIsPlan => _isPlan;
  bool? get getIsDelivery => _isDelivery;
  Address? get getCustomDeliveryAddress => _customDeliveryAddress;
  String? get getDeliveryTime => _deliveryTime;
  String? get getTakeAwayTime => _takeAwayTime;

  set setId(String? id) => _id = id;
  set setRequester(User? requester) => _requester = requester;
  set setProducts(List<Map<String, Object>>? products) => _products = products;
  set setComments(String? comments) => _comments = comments;
  set setPaymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;
  set setValue(double? value) => _value = value;
  set setIsPlan(bool? isPlan) => _isPlan = isPlan;
  set setIsDelivery(bool? isDelivery) => _isDelivery = isDelivery;
  set setCustomDeliveryAddress(Address? customDeliveryAddress) =>
      _customDeliveryAddress = customDeliveryAddress;
  set setDeliveryTime(String? deliveryTime) => _deliveryTime = deliveryTime;
  set setTakeAwayTime(String? takeAwayTime) => _takeAwayTime = takeAwayTime;

  _productsToMap() {
    Map<String, Map<String, Object>> aux = {};
    for (int i = 0; i < getProducts!.length; i++) {
      //aux.putIfAbsent('Product $i', () => _products![i]);
      Product product = _products![i]['Product']! as Product;
      int quantity = int.parse(_products![i]['Quantity']!.toString());
      aux['Product ${i+1}'] = {
        'product': product.name!,
        'quantity': quantity,
      };
    }
    return aux;
  }

  Map<String, dynamic> toMap() {
    print("## PRODUCTS TO MAP: ${_productsToMap()}");
    return {
      "requester": {
        "user": {
          "email": _requester!.getEmail,
          "client": {
            "name": _requester!.getClient!.getName,
          },
        },
      },
      "products": _productsToMap(),
      "comments": _comments,
      "paymentMethod": _paymentMethod,
      "value": _value,
      "isPlan": _isPlan,
      "isDelivery": _isDelivery,
      "customDeliveryAddress": _customDeliveryAddress ?? "",
      "deliveryTime": _deliveryTime ?? "",
      "takeAwayTime": _takeAwayTime ?? "",
    };
  }

  @override
  String toString() {
    return "Order: {id: $_id, requester: ${_requester.toString()}, products: ${_products.toString()}, comments: $_comments, paymentMethod: ${_paymentMethod.toString()}, value: $_value, isPlan: $_isPlan, isDelivery: $_isDelivery, customDeliveryAddress: ${_customDeliveryAddress.toString()}, deliveryTime: $_deliveryTime, takeAwayTime: $_takeAwayTime}";
  }
}
