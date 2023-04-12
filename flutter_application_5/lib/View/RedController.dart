import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_5/bloc/red_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedController extends StatelessWidget {
  const RedController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              // antes do add -> Busca na árvore de widget (De baixo para cima) o objeto RedBloc mais próximo
              // add -> emite o evento passado como parametro
              BlocProvider.of<RedBloc>(context).add(SemRed());
            },
            child: const Text("Sem")),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<RedBloc>(context).add(PoucoRed());
            },
            child: const Text("Pouco")),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<RedBloc>(context).add(NormalRed());
            },
            child: const Text("Normal")),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<RedBloc>(context).add(MuitoRed());
            },
            child: const Text("Muito")),
      ],
    );
  }
}
