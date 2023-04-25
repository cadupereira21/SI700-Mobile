import 'dart:ffi';

import 'package:app_seu_madeu_sucos/View/Logic/CartInfo.dart';
import 'package:flutter/material.dart';

import '../Entities/Product.dart';
import '../Logic/ProductsInfo.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> allProducts = ProductsInfo.allProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allProducts.length,
      itemBuilder: (BuildContext context, int index) =>
          productTile(allProducts[index]));
  }

  Widget productTile(Product product) {
    return Card(
      margin: const EdgeInsets.all(7),
      elevation: 5,
      color: Colors.green,
      child: ListTile(
        leading: productImage(),
        title: Text("${product.name}"),
        subtitle: Text(product.description!),
        trailing: addToCartButton(product),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }

  SnackBar addedToCartSnackbar(Product product) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("${product.name} adicionado ao carrinho!"),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          CartInfo.removeFromCart(product);
        }
      ),
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
          padding: const EdgeInsets.all(17),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          CartInfo.addToCart(product);
          ScaffoldMessenger.of(context)
              .showSnackBar(addedToCartSnackbar(product));
        },
        child: const Icon(
          Icons.add_shopping_cart_sharp,
          size: 22,
        ));
  }
}
