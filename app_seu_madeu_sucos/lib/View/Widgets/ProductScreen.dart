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
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      padding: EdgeInsets.all(17),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      //TODO: Adicionar produto ao carrinho
                      ScaffoldMessenger.of(context).showSnackBar(addedToCartSnackbar(index));
                    },
                    child: const Icon(
                      Icons.add_shopping_cart_sharp,
                      size: 22,
                    )),
                contentPadding: const EdgeInsets.all(15),
                onTap: () {
                  //TODO: Open single product screen
                },
              ),
            ));
  }

  SnackBar addedToCartSnackbar(int productIndex) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("Produto $productIndex adicionado ao carrinho!"),
      action: SnackBarAction(
        label: "Desfazer", 
        onPressed: (){
          //TODO: Desfazer ação de adicionar
        }
      ),
    );
  }
}
