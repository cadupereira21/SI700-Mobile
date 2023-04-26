import 'package:aula6/View/Screens/BasicListView.dart';
import 'package:aula6/View/Screens/DynamicListView.dart';
import 'package:flutter/material.dart';

import 'View/Screens/FutureScreen.dart';

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
        primarySwatch: Colors.red,
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
  var _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _currentScreen,
        children: [const BasicListView(), DynamicListView(), FutureScreen()],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("Aula 06", style: TextStyle(fontSize: 24)),
            ),
            ListTile(
              title: const Text("Basic list view"),
              onTap: () {
                setState(() {
                  _currentScreen = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Dynamic list view"),
              onTap: () {
                setState(() {
                  _currentScreen = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Future Screen"),
              onTap: () {
                setState(() {
                  _currentScreen = 2;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Floating Actions Button',
        child: const Icon(Icons.add),
      ),
    );
  }
}
