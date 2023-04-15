import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Theme Activity',
      theme: ThemeData(
        primarySwatch: Colors.red, 
      ),
      home: const MyHomePage(title: 'Dark Theme Activity'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 187, 49, 40),
                    foregroundColor: Colors.black87,
                    ),
                  child: const Text("Dark Mode"),
                ),
                ElevatedButton(
                  onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 187, 49, 40),
                    foregroundColor: Colors.black87,
                  ),
                  child: const Text("Normal Mode"),
                ),
              ],
            ),
            Center(
              child: Image.asset(
                'Assets/perfil1.jpg',
                height: 300,
              )
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Switch Theme',
        child: const Icon(Icons.dark_mode),
        backgroundColor: const Color.fromARGB(255, 187, 49, 40),
        foregroundColor: Colors.black87,
      ),
    );
  }
}
