import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';

import '../Model/Order.dart';
import 'UserData.dart';

class NewOrderData {
  static NewOrderData instance = NewOrderData._createInstance();
  NewOrderData._createInstance();

  Order _order = Order(
    id: "",
    requester: UserData.instance.user,
    products: List.empty(),
    comments: "",
    paymentMethod: PaymentMethod.list[0],
    value: 0.0,
    isPlan: false,
    isDelivery: false,
    customDeliveryAddress: null,
    deliveryTime: "",
  );

  set setOrder(Order order) => _order = order;
  get getOrder => Order(
        id: _order.getId,
        requester: _order.getRequester,
        products: _order.getProducts,
        comments: _order.getComments,
        paymentMethod: _order.getPaymentMethod,
        value: _order.getValue,
        isPlan: _order.getIsPlan,
        isDelivery: _order.getIsDelivery,
        customDeliveryAddress: _order.getCustomDeliveryAddress,
        deliveryTime: _order.getDeliveryTime,
      );

  void clearData() {
    Order auxOrder = Order(
      id: "",
      requester: UserData.instance.user,
      products: List.empty(),
      comments: "",
      paymentMethod: PaymentMethod.list[0],
      value: 0.0,
      isPlan: false,
      isDelivery: false,
      customDeliveryAddress: null,
      deliveryTime: "",
    );

    setOrder = auxOrder;
  }
}
