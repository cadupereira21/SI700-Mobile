import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'HistoryPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: currentScreen,
        children: const [
          HistoryPage(),
          CartPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Novo Pedido',
        child: const Icon(Icons.shopping_bag),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: "Histórico de pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Carrinho"),
        ],
        currentIndex: currentScreen,
        fixedColor: Colors.lightGreen,
      ),
    );
  }
}
