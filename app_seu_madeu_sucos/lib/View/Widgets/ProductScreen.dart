import 'dart:ffi';

import 'package:app_seu_madeu_sucos/View/Logic/CartInfo.dart';
import 'package:flutter/material.dart';

import '../Interfaces/Product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> allProducts = [
    Product(id: 1, name: "Suco 1", description: "Suco de Laranja")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => productTile(allProducts[index]));
  }

  Widget productTile(Product product) {
    return Card(
      margin: const EdgeInsets.all(7),
      elevation: 5,
      color: Colors.green,
      child: ListTile(
        leading: productImage(),
        title: Text("Produto ${product.id}"),
        subtitle: const Text("Descrição do produto"),
        trailing: addToCartButton(product),
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }

  SnackBar addedToCartSnackbar(double? productIndex) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("Produto $productIndex adicionado ao carrinho!"),
      action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            //TODO: Desfazer ação de adicionar
          }),
    );
  }

  Widget productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        'lib/Assets/seuMadeu.jpeg',
      ),
    );
  }

  Widget addToCartButton(Product product) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          padding: EdgeInsets.all(17),
          shape: CircleBorder(),
        ),
        onPressed: () {
          CartInfo.addToCart(product);
          ScaffoldMessenger.of(context)
              .showSnackBar(addedToCartSnackbar(product.id));
        },
        child: const Icon(
          Icons.add_shopping_cart_sharp,
          size: 22,
        ));
  }
}
