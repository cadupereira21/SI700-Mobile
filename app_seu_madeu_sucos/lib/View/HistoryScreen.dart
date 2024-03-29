import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/Order/OrderMonitorBloc.dart';
import '../Controller/Monitor/Order/OrderMonitorState.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterBloc.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterState.dart';
import '../Data/OrderCollectionData.dart';
import '../Model/Order.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _orderCollectionData = OrderCollectionData.instance;

  var customGreenColor = const Color.fromRGBO(67, 160, 71, 1);

  @override
  Widget build(BuildContext context) {
    var allOrders = _orderCollectionData.getAllOrders;
    var orderRequesterBloc = BlocProvider.of<OrderRequesterBloc>(context);

    if (allOrders.isEmpty) {
      orderRequesterBloc.add(GetAllOrdersRequest());
    }

    return BlocBuilder<OrderRequesterBloc, OrderRequesterState>(
      builder: (context, state) => state is ProcessingOrderRequestState
          ? const Center(child: CircularProgressIndicator())
          : _historyScreenContent(),
    );
  }

  Widget _historyScreenContent() {
    return BlocBuilder<OrderMonitorBloc, OrderMonitorState>(
        builder: (context, state) {
      return state.orderCollection.isEmpty
          ? _noOrderScreen()
          : ListView.builder(
              itemCount: state.orderCollection.length,
              itemBuilder: (BuildContext context, int index) =>
                  orderTile(state.orderCollection[index]),
            );
    });
  }

  orderTile(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: customGreenColor))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              children: [
                _idAndValueRow(order),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft, 
                    child: Text(
                      order.getIsPlan! 
                        ? "Pedido de plano"
                        : "",
                      style: TextStyle(color: customGreenColor),
                    ),
                  ),
                ),
                _productsList(order),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _noOrderScreen() {
    var textPaddingTop = const EdgeInsets.only(top: 10.0);
    const textStyle = TextStyle(
      color: Color.fromRGBO(0, 0, 0, .6),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Você não fez nenhum pedido ainda",
          style: textStyle,
        ),
        Padding(
          padding: textPaddingTop,
          child: const Text(":(", style: textStyle),
        )
      ],
    ));
  }

  Widget _idAndValueRow(Order order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${order.getId}",
          style: TextStyle(
            color: customGreenColor,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${order.getPaymentMethod} - ",
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, .5),
                fontSize: 14,
              ),
            ),
            Text(
              "R\$${order.getValue!.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productsList(Order order) {
    return Padding(
      padding: order.getIsPlan!
        ? const EdgeInsets.only(top: 15.0)
        : const EdgeInsets.only(top: 0.0),
      child: SizedBox(
        height: order.getProducts!.length * 18,
        child: ListView.builder(
            itemCount: order.getProducts!.length,
            itemBuilder: (context, index) =>
                _productRow(order.getProducts![index])),
      ),
    );
  }

  Widget _productRow(Map<String, Object> productMap) {
    return Text(
      "${productMap['Quantity'].toString()}x   ${productMap['Product'].toString()}",
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, .6)
      ),
    );
  }
}
