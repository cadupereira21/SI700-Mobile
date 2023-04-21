import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: [
            formEmailField("Email"),
            formPasswordField("Senha"),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  formButton("Entrar"),
                  formButton("Cadastrar"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formEmailField(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Senha'
        ),
        cursorColor: Colors.lightGreen,
      )
    );
  }

  Widget formPasswordField(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Senha'
        ),
        cursorColor: Colors.lightGreen,
        obscureText: true,
      )
    );
  }

  Widget formButton(String text) {
    return ElevatedButton(
        onPressed: () {},
        child: Padding(padding: const EdgeInsets.all(10), child: Text(text)));
  }
}
