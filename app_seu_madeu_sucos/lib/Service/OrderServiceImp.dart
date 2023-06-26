
import 'package:app_seu_madeu_sucos/Service/Service.dart';
import 'package:uuid/uuid.dart';

import '../Model/Order.dart';
import 'RequestStatus.dart';

class OrderServiceImp extends Service {
  static final OrderServiceImp instance = OrderServiceImp._internal();

  static const REQ_TITLE_CREATE_ORDER = "Create Order Request";

  OrderServiceImp._internal();

  Future<void> createOrder(Order order) async {
    final orderId = const Uuid().v1();

    final createOrderResponse = await dio.post(
      "$baseUrl/orders/${orderId}.json",
      data: order.toMap(),
    );

    // for (int i = 0; i < order.getProducts!.length; i++) {
    //   Product product = order.getProducts![i]['Product'] as Product;
    //   int quantity = int.parse(order.getProducts![i]['Quantity'].toString());
    //   final createOrderProductResponse = await dio.post(
    //     "$baseUrl/orders/${orderId}/products.json",
    //     data: json.encode({
    //       "product": product.getName,
    //       "quantity": quantity,
    //     }),
    //   );

    //   if (createOrderResponse.statusCode!.toInt() / 100 != 2) {
    //     notify(
    //       requestTitle: OrderServiceImp.REQ_TITLE_CREATE_ORDER,
    //       responseStatus: RequestStatus.FAILED,
    //       object: [],
    //     );
    //   }
    // }

    notify(
      requestTitle: OrderServiceImp.REQ_TITLE_CREATE_ORDER,
      responseStatus: createOrderResponse.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [orderId, order],
    );
  }
}
