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
  final _paymentMethodFormKey = GlobalKey<FormState>();

  bool _useCustomAddress = false;

  Order _order = OrderData.instance.getOrder;
  final EdgeInsets _buttonSizePadding = const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 17.0,
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
          child: bottomContentFields(),
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

  Widget bottomContentFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Total: R\$100,00",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paymentMethodDropdown(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isDeliveryCheckbox(),
                  useRegisteredAddress(),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customElevatedButton(
                buttonText: "Cancelar",
                onPressed: (){
                  //TODO: Esvaziar OrderData
                  print("Order screen: Cancelei um pedido");
                  Navigator.pop(context);
                }
              ),
              customElevatedButton(
                buttonText: "Enviar",
                onPressed: (){
                  // Enviar requisição de criação de pedido
                  print("Order Screen: Enviei um pedido");
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentMethodDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Método de Pagamento",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        DropdownButton(
          value: _order.getPaymentMethod,
          items:
              PaymentMethod.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _order.setPaymentMethod = value;
            });
          },
        )
      ],
    );
  }

  Widget isDeliveryCheckbox() {
    return Row(
      children: [
        const Text("Quero que entregue"),
        Checkbox(
          checkColor: Colors.white,
          value: _order.getIsDelivery,
          onChanged: (bool? value) {
            setState(() {
              _order.setIsDelivery = value!;
            });
          },
        ),
      ],
    );
  }

  Widget useRegisteredAddress() {
    bool _isDisabled = !_order.getIsDelivery!;
    return Row(
      children: [
        Text(
          "Usar endereço cadastrado",
          style: TextStyle(color: _isDisabled ? Colors.black54 : Colors.black),
        ),
        Checkbox(
          checkColor: Colors.white,
          value: _useCustomAddress,
          onChanged: _isDisabled
              ? null
              : (bool? value) {
                  setState(() {
                    _useCustomAddress = value!;
                  });
                },
        ),
      ],
    );
  }

  customElevatedButton({required String buttonText, void Function()? onPressed}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          buttonText == "Cancelar" ? Colors.red : null
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: _buttonSizePadding,
        child: Text(buttonText),
      ),
    );
  }
}
