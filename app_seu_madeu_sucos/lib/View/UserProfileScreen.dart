import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Data/UserData.dart';
import 'Signup/SignupFormFieldName.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<UserRequesterBloc>(context).add(GetUserEvent(userId: UserData.instance.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                children: [
                  formTextField(SignupFormFieldName.NAME, textFieldOnSaved, "Nome"),
                  formTextField(SignupFormFieldName.PHONE, textFieldOnSaved, "Telefone"),
                  formTextField(SignupFormFieldName.STREET, textFieldOnSaved, "Rua"),
                  formTextField(
                    SignupFormFieldName.STREET_NUMBER, textFieldOnSaved, "Número"
                  ),
                  formTextField(SignupFormFieldName.NEIGHBOUR, textFieldOnSaved, "Bairro"),
                  formTextField(SignupFormFieldName.CITY, textFieldOnSaved, "Cidade"),
                  formTextField(SignupFormFieldName.DISTRICT, textFieldOnSaved, "Estado"),
                  formTextField(SignupFormFieldName.ZIPCODE, textFieldOnSaved, "CEP"),
                  formTextField(SignupFormFieldName.EMAIL, textFieldOnSaved, "Email"),
                  formNewPasswordField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        formButton("Salvar", (){}), 
                        formButton("Voltar", (){
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formTextField(String text, void Function(String?) onSaved, String initialValue) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          initialValue: initialValue,
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

  Widget formNewPasswordField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Nova Senha'),
          cursorColor: Colors.green,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            //LoginInfo.instance.setPassword(value!);
          },
        ));
  }

  Widget formButton(String text, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: text == "Salvar" ? Colors.green : Colors.red,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }

  void textFieldOnSaved(String? value) {}
}
