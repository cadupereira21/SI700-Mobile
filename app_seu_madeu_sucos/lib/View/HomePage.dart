import 'dart:io';

import 'package:app_seu_madeu_sucos/Controller/Monitor/User/UserMonitorState.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/View/UserPlanScreen.dart';
import 'package:app_seu_madeu_sucos/View/UserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Monitor/User/UserMonitorBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterState.dart';
import '../Data/UserData.dart';
import 'CartScreen.dart';
import 'HistoryScreen.dart';
import 'ProductScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var userMonitorBloc = BlocProvider.of<UserMonitorBloc>(context); // Para inicializar o user monitor
    if(UserData.instance.user.getClient.getName == ""){
      BlocProvider.of<UserRequesterBloc>(context).add(GetUserRequest(userEmail: UserData.instance.user.getEmail));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            currentScreen == 0
              ? "Pedidos feitos"
              : currentScreen == 1
                ? "Escolha seu produto"
                : "Carrinho"
          ),
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
    return BlocBuilder<UserRequesterBloc, UserRequesterState>(
      builder: (context, state) {
        return state is ProcessingUserRequestState
          ? const Center(child: CircularProgressIndicator(),)
          : Drawer(
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
                          AuthRequesterBloc authBloc = BlocProvider.of<AuthRequesterBloc>(context);
                          authBloc.add(SignOutRequest());
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
    );
  }

  Widget drawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(UserData.instance.user.getClient.getName),
      accountEmail: Text(
        UserData.instance.user.getEmail,
        style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      ),
      currentAccountPicture: const CircleAvatar(),
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
