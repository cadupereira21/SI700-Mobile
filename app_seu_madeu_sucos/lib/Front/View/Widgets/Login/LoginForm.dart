import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthBloc.dart';
import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            formEmailField(),
            formPasswordField(),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  formButton("Entrar", loginAction),
                  formButton("Cadastrar", (){}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formEmailField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          cursorColor: Colors.green,
        ));
  }

  Widget formPasswordField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Senha'),
          cursorColor: Colors.green,
          obscureText: true,
        ));
  }

  Widget formButton(String text, void Function() onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Padding(padding: const EdgeInsets.all(10), child: Text(text)));
  }

  void loginAction() {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(LogIn());
  }
}
