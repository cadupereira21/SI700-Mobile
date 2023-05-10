import 'package:flutter_application_1/bloc/manage_db_bloc.dart';
import 'package:flutter_application_1/screens/add_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('widgets_values');
  await Hive.openBox("list_view_data");
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
  var _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: IndexedStack(index: _currentScreen, children: [const AddNotes()]),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Tela 1"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Tela 2"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Tela 3"),
          ],
          currentIndex: _currentScreen,
          onTap: (value) {
            setState(() {
              _currentScreen = value;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
