import 'package:activity2/Bloc/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/ThemeBloc.dart';
import 'Bloc/ThemeEvent.dart';
import 'View/View.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ThemeBloc(NormalTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp(
          title: 'Dark Theme Activity',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: state.swatch)),
          home: const MyHomePage(title: 'Dark Theme Activity'),
        );
      }),
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
      body: const View(),
      floatingActionButton: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
        return FloatingActionButton(
          onPressed: () {
            state.isDark ? themeBloc.add(TurnNormalTheme()) : themeBloc.add(TurnDarkTheme());
          },
          tooltip: 'Switch Theme',
          child: const Icon(Icons.dark_mode),
        );
      }),
    );
  }
}
