import 'package:activity2/Bloc/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/ThemeBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return MaterialApp(
      title: 'Dark Theme Activity',
      theme: ThemeData(
        primarySwatch: themeState.mainColor,
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
      body: BlocProvider(
        create: (BuildContext context) => ThemeBloc(NormalTheme()),
        child: const Text("Carlos")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Switch Theme',
        backgroundColor: const Color.fromARGB(255, 187, 49, 40),
        foregroundColor: Colors.black87,
        child: const Icon(Icons.dark_mode),
      ),
    );
  }
}
