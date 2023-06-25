import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/Order/OrderMonitorBloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    var orderMonitorBloc = BlocProvider.of<OrderMonitorBloc>(context);
    return const Text("History Screen");
  }
}
