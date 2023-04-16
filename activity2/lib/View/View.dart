import 'package:activity2/Bloc/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/ThemeBloc.dart';
import '../Bloc/ThemeEvent.dart';

class View extends StatelessWidget {
  const View({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          color: state.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      themeBloc.add(TurnDarkTheme());
                    },
                    child: const Text("Dark Mode"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      themeBloc.add(TurnNormalTheme());
                    },
                    child: const Text("Normal Mode"),
                  ),
                ],
              ),
              Center(
                child: Image.asset(
                state.isDark?'Assets/perfil1.jpg':'Assets/perfil2.jpeg',
                height: 300,
                )
              ),
            ]
          ),
        );
      }
    );
  }
}
