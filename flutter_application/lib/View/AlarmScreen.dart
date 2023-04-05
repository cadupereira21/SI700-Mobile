import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey();
    return Form(
        child: Column(children: [
      TextFormField(
        key: formKey,
        validator: (String? value) {
          // se houver erro, retorna algo
          if (value != null) {
            if (value.isEmpty) {
              return "Insira o nome de usuário";
            } else {
              return "Você não adicionou nada";
            }
          }
          return null;
        },
        onSaved: (value) {},
      ),
      ElevatedButton(onPressed: () {}, child: const Text("Login"))
    ] //Column > children
            ));
  }
}
