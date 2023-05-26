import '../Model/Product.dart';
import 'RequestStatus.dart';
import 'Service.dart';

class ProductServiceImp extends Service {
  static const String REQ_TITLE_GET_PRODUCT = "Get User Request";

  static final ProductServiceImp instance = ProductServiceImp._internal();
  ProductServiceImp._internal();

  Future<List<Product>?> getAllProducts() async {
    List<Product> productColletion = [];
    final response = await dio.get("$baseUrl}/products.json");

    print(response.data.toString());
    //Put products on list
    //Notify
    return null;
  }
}
