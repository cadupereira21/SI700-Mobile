import 'package:app_seu_madeu_sucos/View/Signup/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/Requester/Authentication/AuthRequesterBloc.dart';
import '../../Controller/Requester/Authentication/AuthRequesterEvent.dart';
import '../../Model/UserModel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final UserModel _user = UserModel();

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
            forgotMyPasswordButton(),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  formButton("Entrar", loginAction),
                  formButton("Cadastre-se", signUpAction),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Email',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        showCursor: false,
        onChanged: (value) {
          _formKey.currentState!.validate();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira um email';
          } else if (!value.contains("@") || !value.contains(".")) {
            return "Por favor insira um email válido!";
          }
          return null;
        },
        onSaved: (value) {
          _user.setEmail = value!;
        },
      ),
    );
  }

  Widget formPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Senha',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        showCursor: false,
        obscureText: true,
        onChanged: (value) {
          _formKey.currentState!.validate();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira uma senha';
          } else if (value.length < 8) {
            return "Sua senha deverá conter no mínimo 8 caracteres";
          }
          return null;
        },
        onSaved: (value) {
          _user.setPassword = value!;
        },
      ),
    );
  }

  Widget formButton(String text, void Function() onPressed) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange.shade600),
        ),
        onPressed: onPressed,
        child: Padding(padding: const EdgeInsets.all(10), child: Text(text)));
  }

  Widget forgotMyPasswordButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      TextButton(
        onPressed: () {
          // TODO: Realizar ação de esqueci minha senha
        },
        child: const Text(
          "Esqueceu sua senha?",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ]);
  }

  void loginAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      AuthRequesterBloc authBloc = BlocProvider.of<AuthRequesterBloc>(context);
      authBloc.add(AuthenticateRequest(user: _user));
    }
  }

  void signUpAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
