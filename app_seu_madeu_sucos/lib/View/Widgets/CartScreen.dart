import 'package:flutter/material.dart';

import '../Entities/Product.dart';
import '../Logic/CartInfo.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var addedProducts = CartInfo.addedProducts;
  bool isPlan = false;

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
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Pedido de plano"),
                      Switch(
                      //thumbIcon: thumbIcon,
                        value: isPlan,
                        onChanged: (bool value) {
                          setState(() {
                            isPlan = value;
                          });
                        }
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: (){
                          //TODO: Descartar o carrinho
                        }, 
                        child: const Text("Cancelar")
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: (){
                          //TODO: Seguir para a tela de pedido
                        }, 
                        child: const Text("Continuar")
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  productTile(Map<String, Object> element) {
    Product product = element['Product'] as Product;
    int quantity = element['Quantity'] as int;
    return Card(
      //margin: const EdgeInsets.all(7),
      child: ListTile(
        leading: Text(
          "${quantity}x",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        title: Text("${product.name}"),
        subtitle: Text(product.description!),
        trailing: removeProduct(product),
        //contentPadding: const EdgeInsets.all(10),
      ),
    );
  }

  removeProduct(Product product) {
    return IconButton(
        onPressed: () {
          CartInfo.removeFromCart(product);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 22,
        ));
  }
}
