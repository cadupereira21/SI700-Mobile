import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Data/UserData.dart';
import '../Model/User.dart';
import 'Signup/SignupFormFieldName.dart';
import 'TextFormFieldFormat.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  User user = UserData.instance.user;
  //var clientAddress = UserData.instance.user.client!.address!;

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
                  formTextField(
                    text: SignupFormFieldName.NAME,
                    initialValue: user.client!.name!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      } else if (
                        TextFormFieldFormat.checkIfStringHasNumber(value) ||
                        TextFormFieldFormat.checkIfStringHasSpecialCharacters(value)) {
                        return "Esse campo só aceita letras!";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.client!.name = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.PHONE,
                    initialValue: user.client!.phone!,
                    onSaved: (value) {
                      user.client!.phone = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.STREET,
                    initialValue: user.client!.address!.street!,
                    onSaved: (value) {
                      var auxValue = value!.split(" ");
                      value = "";
                      for (int i = 0; i < auxValue.length; i++) {
                        auxValue[i] =
                            "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                        value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                      }

                      user.client!.address!.street = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.STREET_NUMBER,
                    initialValue: user.client!.address!.streetNumber!.toString(),
                    onSaved: (value) {
                      user.client!.address!.streetNumber = int.parse(value!);
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.NEIGHBOUR,
                    initialValue: user.client!.address!.neighbour!,
                    onSaved: (value) {
                      var auxValue = value!.split(" ");
                      value = "";
                      for (int i = 0; i < auxValue.length; i++) {
                        auxValue[i] =
                            "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                        value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                      }

                      user.client!.address!.neighbour = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.CITY,
                    initialValue: user.client!.address!.city!,
                    onSaved: (value) {
                      user.client!.address!.city = "${value!.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.DISTRICT,
                    initialValue: user.client!.address!.district!,
                    onSaved: (value) {
                      user.client!.address!.district = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.ZIPCODE,
                    initialValue: user.client!.address!.cep!,
                    onSaved: (value) {
                      user.client!.address!.cep = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.EMAIL,
                    initialValue: user.email!,
                    onSaved: (value) {
                      user.email = value;
                    },
                  ),
                  formNewPasswordField(),
                  deleteUserButton(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        formButton("Salvar", _updateAction),
                        formButton("Voltar", () {
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

  Widget formTextField({
    required String text,
    required String initialValue, 
    required void Function(String?) onSaved, 
    String? Function(String?)? validator,
  }) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(labelText: text),
          cursorColor: Colors.green,
          validator: validator ??
            (value) {
              return null;
            },
          onSaved: onSaved,
        ));
  }

  Widget formNewPasswordField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nova Senha',
          ),
          cursorColor: Colors.green,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            UserData.instance.user.password = value;
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

  Widget deleteUserButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      TextButton(
          onPressed: () {
            BlocProvider.of<UserRequesterBloc>(context)
                .add(DeleteUserRequest(userId: UserData.instance.id));
          },
          child: const Text(
            "Excluir conta",
            style: TextStyle(color: Colors.red),
          )),
    ]);
  }

  _updateAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<UserRequesterBloc>(context)
          .add(UpdateUserRequest(userId: UserData.instance.id, user: user));
    }
  }
}
