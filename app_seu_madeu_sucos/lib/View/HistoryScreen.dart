import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/Order/OrderMonitorBloc.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterBloc.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterEvent.dart';
import '../Data/OrderCollectionData.dart';

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

    return const Text("History Screen");
  }
}
