import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Screen/Bloc/CartController/CartBloc.dart';
import '../Controller/Screen/Bloc/CartController/CartEvent.dart';
import '../Controller/Screen/Bloc/CartController/CartState.dart';
import '../../Model/Product.dart';
import '../Data/CartData.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //var addedProducts = CartInfo.addedProducts;
  bool isPlan = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: state.addedProducts.length,
                  itemBuilder: (BuildContext context, int index) =>
                      productTile(state.addedProducts[index]));
            }
          ),
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
                          value: isPlan,
                          onChanged: (bool value) {
                            setState(() {
                              isPlan = value;
                            });
                          }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                              ClearCart()
                            );
                            //TODO: Mudar para a tela de produtos
                          },
                          child: const Text("Cancelar")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            //TODO: Seguir para a tela de pedido
                          },
                          child: const Text("Continuar")),
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
          setState(() => CartData.instance.removeFromCart(product));
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 22,
        ));
  }
}
