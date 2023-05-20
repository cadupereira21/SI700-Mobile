import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthBloc.dart';
import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Logic/LoginInfo.dart';
import 'SignupFormFieldName.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            children: [
              formTextField(SignupFormFieldName.NAME, textFieldOnSaved),
              formTextField(SignupFormFieldName.PHONE, textFieldOnSaved),
              formTextField(SignupFormFieldName.STREET, textFieldOnSaved),
              formTextField(
                SignupFormFieldName.STREET_NUMBER, textFieldOnSaved,
              ),
              formTextField(SignupFormFieldName.NEIGHBOUR, textFieldOnSaved),
              formTextField(SignupFormFieldName.CITY, textFieldOnSaved),
              formTextField(SignupFormFieldName.DISTRICT, textFieldOnSaved),
              formTextField(SignupFormFieldName.ZIPCODE, textFieldOnSaved),
              formTextField(SignupFormFieldName.EMAIL, textFieldOnSaved),
              formPasswordField(),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    formButton("Cadastrar", () {}), 
                    formButton("Cancelar", () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formTextField(String text, void Function(String?) onSaved) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: InputDecoration(labelText: text),
          cursorColor: Colors.green,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira seu ${text.toLowerCase()}';
            }
            return null;
          },
          onSaved: onSaved,
        ));
  }

  Widget formPasswordField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Senha'),
          cursorColor: Colors.green,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            LoginInfo.instance.setPassword(value!);
          },
        ));
  }

  Widget formButton(String text, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: text == "Cadastrar" ? Colors.green : Colors.red,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: text == "Cadastrar" ? 
            const EdgeInsets.symmetric(vertical: 15, horizontal: 45)
            : const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }

  void textFieldOnSaved(String? value) {}

  void SignUpAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Enviar requisição p/ cadastro
      // TODO: Realizar login
    }
  }

  void cancelAction() {
    //TODO: Cancel action
  }
}
