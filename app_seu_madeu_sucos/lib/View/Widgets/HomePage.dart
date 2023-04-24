import 'package:app_seu_madeu_sucos/View/Widgets/UserPlanScreen.dart';
import 'package:app_seu_madeu_sucos/View/Widgets/UserProfileScreen.dart';
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
        drawer: drawer(),
        body: IndexedStack(
          index: currentScreen,
          children: const [
            HistoryPage(),
            ProductScreen(),
            CartPage(),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (int value) {
        setState(() {
          currentScreen = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined), label: "Histórico"),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: "Pedido",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: "Carrinho"),
      ],
      currentIndex: currentScreen,
      fixedColor: Colors.green,
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Nome Completo do Usuário"),
            accountEmail: Text(
              "Email completo do usuário",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            currentAccountPicture: CircleAvatar(),
          ),
          ListTile(
            title: const Text("Perfil"),
            textColor: Colors.green,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileScreen()));
            },
          ),
          ListTile(
            title: const Text("Planos"),
            textColor: Colors.green,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserPlanScreen()));
            },
          ),
        ],
      ),
    );
  }
}
