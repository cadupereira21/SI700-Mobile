import 'package:app_seu_madeu_sucos/View/UserPlanScreen.dart';
import 'package:app_seu_madeu_sucos/View/UserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/User/UserMonitorBloc.dart';
import '../Controller/Monitor/User/UserMonitorEvent.dart';
import 'CartScreen.dart';
import 'HistoryScreen.dart';
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
            HistoryScreen(),
            ProductScreen(),
            CartScreen(),
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          drawerHeader(),
          drawerTile("Perfil", const UserProfileScreen()),
          drawerTile("Planos", const UserPlanScreen()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: (){
                    UserMonitorBloc accessBloc = BlocProvider.of<UserMonitorBloc>(context);
                    accessBloc.add(LogOutButtonClick());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
                    child: Text("Sair"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget drawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text("Nome Completo do Usuário"),
      accountEmail: Text(
        "Email completo do usuário",
        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      ),
      currentAccountPicture: CircleAvatar(),
    );
  }

  Widget drawerTile(String title, Widget pushPage) {
    return ListTile(
      title: Text(title),
      textColor: Colors.green,
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => pushPage),
        );
      },
    );
  }
}
