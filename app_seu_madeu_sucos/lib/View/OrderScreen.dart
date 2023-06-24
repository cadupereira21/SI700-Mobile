import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Pedido"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: screenScrolablleContent(),
    );
  }

  Widget screenScrolablleContent() {
    return Column(
      children: [
        contentFields(),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Total: R\$100,00"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                  ElevatedButton(onPressed: () {}, child: Text("Cancelar")),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget contentFields() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, left: 15.0, right: 15.0, bottom: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Product List View"),
                Text("Checkers and Dropdowns"),
              ],
            ),
            Text("Comments"),
            Text("Address Form"),
          ],
        ),
      ),
    );
  }
}
