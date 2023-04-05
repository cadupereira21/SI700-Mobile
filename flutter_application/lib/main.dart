import 'package:flutter/material.dart';

import 'View/AlarmScreen.dart';
import 'View/ContactScreen.dart';
import 'View/PeopleScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // TAB BAR
      length: 3, // Nos diz que haverá 3 abas
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.alarm_add_sharp)),
            Tab(icon: Icon(Icons.account_box_sharp)),
            Tab(icon: Icon(Icons.accessibility_new_sharp)),
          ]),
        ),
        // body: PageView(
        //   controller: PageController(initialPage: 1),
        //   children: const [Text("Carlos"), Text("Clara"), Text("Ulisses")],
        // ),
        body: const TabBarView(
          children: [
            // Podem ser colocados widgets, sejam classes ou funções
            AlarmScreen(),
            ContactScreen(),
            PeopleScreen(),
          ],
        ), // Corpo das 3 telas diferentes, referentes à tab
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}