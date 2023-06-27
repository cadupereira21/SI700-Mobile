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
  var _orderCollectionData = OrderCollectionData.instance;

  @override
  Widget build(BuildContext context) {
    var _allOrders = _orderCollectionData.getAllOrders;
    var orderRequesterBloc = BlocProvider.of<OrderRequesterBloc>(context);
    var orderMonitorBloc = BlocProvider.of<OrderMonitorBloc>(context);

    if (_allOrders.isEmpty) {
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
      return state.orderCollection.length < 1
          ? _noOrderScreen()
          : ListView.builder(
              itemCount: state.orderCollection.length,
              itemBuilder: (BuildContext context, int index) =>
                  orderTile(state.orderCollection[index]),
            );
    });
  }

  orderTile(Order order) {
    return Card(
      child: ListTile(
        title: Text("${order.getId}"),
      ),
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
}
