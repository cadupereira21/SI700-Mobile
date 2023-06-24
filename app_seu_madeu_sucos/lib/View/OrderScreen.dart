import 'package:app_seu_madeu_sucos/Data/OrderData.dart';
import 'package:app_seu_madeu_sucos/Data/UserData.dart';
import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:app_seu_madeu_sucos/Model/Districts.dart';
import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Model/Order.dart';
import 'Signup/SignupFormFieldName.dart';
import 'TextFormFieldFormat.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _obsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  bool _useRegisteredAddress = false;

  final Order _order = OrderData.instance.getOrder;
  final EdgeInsets _buttonSizePadding = const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 17.0,
  );
  var _districtAddressFormDropdownValue = Districts.list[0];
  var customGreenColor = Color.fromRGBO(67, 160, 71, 1);
  final Address _customAddress = Address();

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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.62,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Form(
                key: _obsFormKey,
                child: obsForm(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: !_order.getIsDelivery! || _useRegisteredAddress ? Container() : addressForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomContentFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Total: R\$${_order.getValue!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
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
                  onPressed: () {
                    //TODO: Esvaziar OrderData
                    debugPrint("Order screen: Cancelei um pedido");
                    Navigator.pop(context);
                  }),
              customElevatedButton(
                buttonText: "Enviar",
                onPressed: () {
                  // Enviar requisição de criação de pedido
                  debugPrint("Order Screen: Enviei um pedido");
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
              _useRegisteredAddress = value;
            });
          },
        ),
      ],
    );
  }

  Widget useRegisteredAddress() {
    bool isDisabled = !_order.getIsDelivery!;
    return Row(
      children: [
        Text(
          "Usar endereço cadastrado",
          style: TextStyle(color: isDisabled ? Colors.black54 : Colors.black),
        ),
        Checkbox(
          checkColor: Colors.white,
          value: _useRegisteredAddress,
          onChanged: isDisabled
              ? null
              : (bool? value) {
                  setState(() {
                    _useRegisteredAddress = value!;
                  });
                },
        ),
      ],
    );
  }

  customElevatedButton(
      {required String buttonText, void Function()? onPressed}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
            buttonText == "Cancelar" ? Colors.red : null),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: _buttonSizePadding,
        child: Text(buttonText),
      ),
    );
  }

  Widget obsForm() {
    return TextFormField(
      expands: false,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        filled: true,
        //fillColor: Colors.white,
        labelText: "Observações",
        labelStyle: TextStyle(color: customGreenColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(color: customGreenColor),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: customGreenColor, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: customGreenColor, width: 1.5)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      cursorColor: Colors.green,
      onSaved: (value) {
        _order.setComments = value;
      },
    );
  }

  Widget addressForm() {
    return Form(
      key: _addressFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          addressFormTextField(
            text: SignupFormFieldName.STREET,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Por favor insira seu endereço";
              }
            },
            onSaved: (value) {
              var auxValue = value!.split(" ");
              value = "";
              for (int i = 0; i < auxValue.length; i++) {
                auxValue[i] =
                    "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
              }

              _customAddress.street = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: addressFormTextField(
                  text: SignupFormFieldName.STREET_NUMBER,
                  mask: TextFormFieldFormat.STREET_NUMBER,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*";
                    }
                  },
                  onSaved: (value) {
                    _customAddress.streetNumber = int.parse(value!);
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: addressFormTextField(
                  text: SignupFormFieldName.NEIGHBOUR,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira seu bairro";
                    }
                  },
                  onSaved: (value) {
                    var auxValue = value!.split(" ");
                    value = "";
                    for (int i = 0; i < auxValue.length; i++) {
                      auxValue[i] =
                          "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                      value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                    }

                    _customAddress.neighbour = value;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: dropdownButton(_customAddress),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: addressFormTextField(
                  text: SignupFormFieldName.CITY,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira sua cidade";
                    }
                  },
                  onSaved: (value) {
                    _customAddress.city =
                        "${value!.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
                  },
                ),
              ),
            ],
          ),
          addressFormTextField(
            text: SignupFormFieldName.ZIPCODE,
            mask: TextFormFieldFormat.ZIPCODE,
            inputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Por favor insira o seu CEP";
              } else if (value.length < 9) {
                return "CEP incompleto";
              }
            },
            onSaved: (value) {
              _customAddress.cep = value;
            },
          ),
        ],
      ),
    );
  }

  Widget addressFormTextField(
      {String? text,
      MaskTextInputFormatter? mask,
      TextInputType? inputType,
      String? Function(String?)? validator,
      void Function(String?)? onSaved}) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          inputFormatters: mask != null ? [mask] : [],
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            //fillColor: Colors.white,
            labelText: text,
            labelStyle: TextStyle(color: customGreenColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(color: customGreenColor),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: customGreenColor, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: customGreenColor, width: 1.5)),
            focusedErrorBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
          cursorColor: Colors.orange.shade600,
          validator: validator ??
              (value) {
                return null;
              },
          onSaved: onSaved,
        ));
  }

  Widget dropdownButton(Address customAddress) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField(
        value: _districtAddressFormDropdownValue,
        decoration: InputDecoration(
          filled: true,
          labelText: "UF",
          labelStyle: TextStyle(color: customGreenColor),
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: customGreenColor, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: customGreenColor, width: 1.5)),
        ),
        items: Districts.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onSaved: (value) {
          customAddress.district = value;
        },
        onChanged: (value) {
          setState(() {
            _districtAddressFormDropdownValue = value!;
          });
        },
      ),
    );
  }
}
