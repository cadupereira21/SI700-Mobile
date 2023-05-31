import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/Monitor/User/UserMonitorBloc.dart';
import '../../Controller/Monitor/User/UserMonitorEvent.dart';
import '../../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../../Data/UserData.dart';
import '../../Model/Client.dart';
import '../../Model/User.dart';
import 'SignupFormFieldName.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  User user = User();
  Client client = Client();

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
              formTextField(
                SignupFormFieldName.NAME,
                (value) {
                  client.name = value;
                },
              ),
              formTextField(
                SignupFormFieldName.PHONE,
                (value) {
                  client.phone = value;
                },
              ),
              formTextField(
                SignupFormFieldName.STREET,
                (value) {
                  // ignore: unnecessary_brace_in_string_interps
                  client.address = value;
                },
              ),
              formTextField(
                SignupFormFieldName.STREET_NUMBER,
                (value) {
                  client.address = "${client.address}, $value";
                },
              ),
              formTextField(
                SignupFormFieldName.NEIGHBOUR,
                (value) {
                  client.address = "${client.address}, $value";
                },
              ),
              formTextField(
                SignupFormFieldName.CITY,
                (value) {
                  client.address = "${client.address}, $value";
                },
              ),
              formTextField(
                SignupFormFieldName.DISTRICT,
                (value) {
                  client.address = "${client.address}-$value";
                },
              ),
              formTextField(
                SignupFormFieldName.ZIPCODE,
                (value) {
                  client.address = "${client.address}, $value";
                },
              ),
              formTextField(
                SignupFormFieldName.EMAIL,
                (value) {
                  user.email = value;
                },
              ),
              formPasswordField(),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    formButton("Cadastrar", SignUpAction),
                    formButton("Cancelar", cancelAction),
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
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Por favor, insira seu ${text.toLowerCase()}';
          //   }
          //   return null;
          // },
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
            user.password = value;
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
          padding: text == "Cadastrar"
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 45)
              : const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }

  void SignUpAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      user.client = client;
      UserRequesterBloc userRequesterBloc =
          BlocProvider.of<UserRequesterBloc>(context);
      userRequesterBloc.add(CreateUserRequest(user));
    }
  }

  void cancelAction() {
    UserMonitorBloc accessBloc = BlocProvider.of<UserMonitorBloc>(context);
    accessBloc.add(CancelSignUpButtonClick());
  }
}
