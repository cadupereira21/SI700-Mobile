import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) => Card(
          margin: const EdgeInsets.all(7),
          elevation: 5,
          color: Colors.green,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'lib/Assets/seuMadeu.jpeg',
              ),
            ),
            title: Text("Produto $index"),
            subtitle: const Text("Descrição do produto"),
            trailing: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.orange,
              child: GestureDetector(
                onTap: (){
                  //TODO: Add product to cart
                },
                child: const Icon(Icons.add_shopping_cart_sharp,)
              ),
            ),
            contentPadding: const EdgeInsets.all(15),
            onTap: (){
              //TODO: Open single product screen
            },
          ),
        )
      );
  }
}
