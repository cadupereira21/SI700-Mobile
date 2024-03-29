import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Data/NewOrderData.dart';
import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:app_seu_madeu_sucos/Model/Districts.dart';
import 'package:app_seu_madeu_sucos/Model/PaymentMethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Controller/Screen/Bloc/CartController/CartBloc.dart';
import '../Controller/Screen/Bloc/CartController/CartEvent.dart';
import '../Controller/Screen/Bloc/CartController/CartState.dart';
import '../Model/Order.dart';
import '../Model/Product.dart';
import 'CreateOrderMonitorScreen.dart';
import 'Signup/SignupFormFieldName.dart';
import 'TextFormFieldFormat.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final NewOrderData _orderData = NewOrderData.instance;

  final _obsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _deliveryOrTakeAwayTimeFormKey = GlobalKey<FormState>();

  bool _useAnotherAddress = false;

  final Order _order = NewOrderData.instance.getOrder;
  final EdgeInsets _buttonSizePadding = const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 17.0,
  );
  var _districtAddressFormDropdownValue = Districts.list[0];
  var customGreenColor = const Color.fromRGBO(67, 160, 71, 1);
  final Address _customAddress = Address();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        padding: EdgeInsets.only(top: 15.0, left: screenWidth*0.04, right: screenWidth*0.04),
        child: scaffoldContent(screenHeight, screenWidth),
      ),
    );
  }

  Widget scaffoldContent(double screenHeight, double screenWidth) {
    return Column(
      children: [
        orderFields(screenHeight, screenWidth),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: bottomContentFields(screenHeight, screenWidth),
          ),
        ),
      ],
    );
  }

  Widget orderFields(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.4,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              child: productListView(screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomContentFields(double screenHeight, double screenWidth) {
    var orderRequesterBloc = BlocProvider.of<OrderRequesterBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Form(
            key: _obsFormKey,
            child: obsForm(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: screenHeight * 0.06,
                  child: Form(
                    key: _deliveryOrTakeAwayTimeFormKey,
                    child: deliveryOrTakeAwayTime(),
                  )),
              Text(
                "Total: R\$${_order.getValue!.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  isDeliveryCheckbox(screenWidth),
                  useAnotherAddress(screenWidth),
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
                    _orderData.clearData();
                    BlocProvider.of<CartBloc>(context).add(ClearCart());
                    debugPrint("Order screen: Cancelei um pedido");
                    Navigator.pop(context);
                  }),
              customElevatedButton(
                buttonText: "Enviar",
                onPressed: () {
                  if (_addressFormKey.currentState != null) {
                    _addressFormKey.currentState!.validate() ? 
                    _addressFormKey.currentState!.save() : null;
                  }
                  _obsFormKey.currentState!.save();
                  _deliveryOrTakeAwayTimeFormKey.currentState!.save();
    
                  _order.setCustomDeliveryAddress = _customAddress;
    
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateOrderMonitorScreen()),
                  );
    
                  orderRequesterBloc.add(CreateOrderRequest(order: _order));
    
                  debugPrint("[Order Screen] Enviei um pedido");
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

  Widget isDeliveryCheckbox(double screenWidth) {
    return Row(
      children: [
        const Text("Quero que entregue"),
        Checkbox(
          checkColor: Colors.white,
          value: _order.getIsDelivery,
          onChanged: (bool? value) {
            setState(() {
              _order.setIsDelivery = value!;
              _useAnotherAddress = value;

              if(_useAnotherAddress){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return _addressFormScreen(screenWidth);
                    }),
                );
              }
            });
          },
        ),
      ],
    );
  }

  Widget useAnotherAddress(double screenWidth) {
    bool isDisabled = !_order.getIsDelivery!;
    return Row(
      children: [
        Text(
          "Usar outro endereço",
          style: TextStyle(color: isDisabled ? Colors.black54 : Colors.black),
        ),
        Checkbox(
          checkColor: Colors.white,
          value: _useAnotherAddress,
          onChanged: isDisabled
              ? null
              : (bool? value) {
                  setState(() {
                    _useAnotherAddress = value!;

                    if(_useAnotherAddress){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) {
                            return _addressFormScreen(screenWidth);
                          }),
                      );
                    }
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
      maxLines: 2,
      decoration: InputDecoration(
        filled: true,
        //fillColor: Colors.white,
        labelText: "Observações",
        labelStyle: const TextStyle(color: Colors.black54),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(color: customGreenColor),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customGreenColor, width: 1.5)),
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      cursorColor: Colors.orange,
      onSaved: (value) {
        _order.setComments = value;
      },
    );
  }

  Widget deliveryOrTakeAwayTime() {
    return TextFormField(
      inputFormatters: [TextFormFieldFormat.TIME],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        //fillColor: Colors.white,
        labelText: _order.getIsDelivery!
            ? "Horário de entrega"
            : "Horário de retirada",
        labelStyle: const TextStyle(color: Colors.black54),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(color: customGreenColor),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customGreenColor, width: 1.5)),
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      cursorColor: Colors.orange,
      onSaved: (value) {
        _order.getIsDelivery!
            ? _order.setDeliveryTime = value
            : _order.setTakeAwayTime = value;
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
              return null;
            },
            onSaved: (value) {
              var auxValue = value!.split(" ");
              value = "";
              for (int i = 0; i < auxValue.length; i++) {
                auxValue[i] =
                    "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
              }

              _customAddress.setStreet = value!;
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
                    return null;
                  },
                  onSaved: (value) {
                    _customAddress.setStreetNumber = int.parse(value!);
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
                    return null;
                  },
                  onSaved: (value) {
                    var auxValue = value!.split(" ");
                    value = "";
                    for (int i = 0; i < auxValue.length; i++) {
                      auxValue[i] =
                          "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                      value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                    }

                    _customAddress.setNeighbour = value!;
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
                    return null;
                  },
                  onSaved: (value) {
                    _customAddress.setCity =
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
              return null;
            },
            onSaved: (value) {
              _customAddress.setCep = value!;
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
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          inputFormatters: mask != null ? [mask] : [],
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            //fillColor: Colors.white,
            labelText: text,
            labelStyle: const TextStyle(color: Colors.black54),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(color: customGreenColor),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black54, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customGreenColor, width: 1.5)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
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
          labelStyle: const TextStyle(color: Colors.black54),
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 1.5)),
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
          customAddress.setDistrict = value!;
        },
        onChanged: (value) {
          setState(() {
            _districtAddressFormDropdownValue = value!;
          });
        },
      ),
    );
  }

  Widget productListView(double screenWidth) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return ListView.builder(
          itemCount: state.addedProducts.length,
          itemBuilder: (BuildContext context, int index) =>
              productTile(state.addedProducts[index], screenWidth));
    });
  }

  productTile(Map<String, Object> element, double screenWidth) {
    Product product = element['Product'] as Product;
    var productNameStrings = product.name!.split("-");
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                productNameStrings[0],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.visible,
              ),
            ),
            Text(
              productNameStrings[1],
              style: const TextStyle(
                  fontSize: 14,
                  //fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, .7)),
            ),
          ],
        ),
        //subtitle: Text(productNameStrings[1]),
        trailing: Text(
          "R\$${product.value!.toStringAsFixed(2)}",
          style: TextStyle(color: customGreenColor),
        ),
        //contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
  
  Widget _addressFormScreen(double screenWidth) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insira seu endereço!"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _useAnotherAddress = false;
            });
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressForm(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Cancelar"),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          setState(() {
                            _useAnotherAddress = false;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Salvar"),
                      ),
                      onPressed: (){
                        if (_addressFormKey.currentState != null) {
                          _addressFormKey.currentState!.validate() ? 
                          _addressFormKey.currentState!.save() : null;
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
