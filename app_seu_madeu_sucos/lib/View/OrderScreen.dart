import 'package:app_seu_madeu_sucos/Data/OrderData.dart';
import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';
import 'package:flutter/material.dart';

import '../Model/Order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Order _order = OrderData.instance.getOrder;
  final EdgeInsets _buttonSizePadding = const EdgeInsets.symmetric(
    vertical: 13.0,
    horizontal: 20.0,
  );

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
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        child: screenScrolablleContent(),
      ),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Total: R\$100,00",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: _buttonSizePadding,
                        child: const Text("Enviar"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: _buttonSizePadding,
                        child: const Text("Cancelar"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget contentFields() {
    return SingleChildScrollView(
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
    );
  }
}
