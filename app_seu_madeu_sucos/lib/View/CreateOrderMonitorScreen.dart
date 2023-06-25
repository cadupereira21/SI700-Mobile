import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/Order/OrderMonitorState.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterBloc.dart';
import '../Controller/Requester/OrderRequester/OrderRequesterState.dart';

class CreateOrderMonitorScreen extends StatefulWidget {
  const CreateOrderMonitorScreen({super.key});

  @override
  State<CreateOrderMonitorScreen> createState() =>
      _CreateOrderMonitorScreenState();
}

class _CreateOrderMonitorScreenState extends State<CreateOrderMonitorScreen> {
  @override
  Widget build(BuildContext context) {
    final orderRequester = BlocProvider.of<OrderRequesterBloc>(context);
    final orderMonitor = BlocProvider.of<OrderMonitorBloc>(context);
  
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 80, vertical: MediaQuery.of(context).size.height * 0.37),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: BlocBuilder<OrderRequesterBloc, OrderRequesterState>(
            builder: (context, state) {
              return state is ProcessingOrderRequestState
                ? const Center(child: CircularProgressIndicator(),)
                : orderMonitor.state is OrderRequestSuccesfulState 
                  ? notificationScreen(
                      text: "Pedido criado com sucesso!",
                      orderMonitorBloc: orderMonitor,
                    )
                  : notificationScreen(
                      text: "Ocorreu um problema na criação do pedido",
                      orderMonitorBloc: orderMonitor,
                    );
            }
          ) 
      )),
    );
  }

  Widget notificationScreen({required String text, required OrderMonitorBloc orderMonitorBloc}){
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Center(
              child: Text(
                orderMonitorBloc.state is OrderRequestSuccesfulState
                  ? "Número do pedido: ${orderMonitorBloc.state.order!.getId!.split("-")[0].toUpperCase()}"
                  : "Descrição: ${orderMonitorBloc.state.message ?? "<mensagemDeErro>"}",
                style:
                    const TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.7)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Ok"),
              ),
            ),
          ],
        );
  }
}
