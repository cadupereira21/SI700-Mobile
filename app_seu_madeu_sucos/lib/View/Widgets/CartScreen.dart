import 'package:flutter/material.dart';

import '../Interfaces/Product.dart';
import '../Logic/CartInfo.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var addedProducts = CartInfo.addedProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: ListView.builder(
              itemCount: addedProducts.length,
              itemBuilder: (BuildContext context, int index) =>
                  productTile(addedProducts[index])),
        ),
        Container(
          color: Colors.red,
        )
      ],
    );
  }

  productTile(Map<String, Object> element) {
    Product product = element['Product'] as Product;
    int quantity = element['Quantity'] as int;
    return Card(
      margin: const EdgeInsets.all(7),
      child: ListTile(
        leading: Text(
          "${quantity}x",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        title: Text("${product.name}"),
        subtitle: Text(product.description!),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
