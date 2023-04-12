import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'View/RedController.dart';
import 'View/RedScreen.dart';
import 'bloc/blueBlock.dart';
import 'bloc/red_bloc.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return RedBloc();
          }),
          BlocProvider(create: (BuildContext context) {
            return BlueBloc();
          }),
        ],
        child: IndexedStack(
          index: currentScreen,
          children: [
            const SingleChildScrollView(child: RedScreen()),
            const RedController(),
            Container(color: Colors.yellow)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "State react"),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: "Event emitter"),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility), label: "Tela amarela"),
        ],
        currentIndex: currentScreen,
        fixedColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
