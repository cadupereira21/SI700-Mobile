import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'HistoryPage.dart';
import 'ProductScreen.dart';

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
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Carlos Eduardo de Andrade Pereira"), 
              accountEmail: Text(
                "carloseduardo2101@gmail.com", 
                style: TextStyle(
                  fontSize: 12, 
                  fontStyle: FontStyle.italic),
              ),
              currentAccountPicture: CircleAvatar(),
            ),
            ListTile(
              title: const Text("Perfil"),
              textColor: Colors.green,
              onTap: (){},
            ),
            ListTile(
              title: const Text("Planos"),
              textColor: Colors.green,
              onTap: (){},
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentScreen,
        children: const [
          HistoryPage(),
          CartPage(),
          ProductScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: "Histórico"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Pedido",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Carrinho"
          ),
        ],
        currentIndex: currentScreen,
        fixedColor: Colors.green,
        
      ),
    );
  }
}
