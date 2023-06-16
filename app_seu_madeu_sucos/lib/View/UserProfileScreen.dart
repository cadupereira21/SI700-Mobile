import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Data/UserData.dart';
import '../Model/User.dart';
import 'Signup/SignupFormFieldName.dart';

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
                    SignupFormFieldName.NAME,
                    (value) {
                      user.client!.name = value;
                    },
                    user.client!.name!,
                  ),
                  formTextField(
                    SignupFormFieldName.PHONE,
                    (value) {
                      user.client!.phone = value;
                    },
                    user.client!.phone!,
                  ),
                  formTextField(
                    SignupFormFieldName.STREET,
                    (value) {
                      var auxValue = value!.split(" ");
                      value = "";
                      for (int i = 0; i < auxValue.length; i++) {
                        auxValue[i] =
                            "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                        value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                      }

                      user.client!.address!.street = value;
                    },
                    user.client!.address!.street!,
                  ),
                  formTextField(
                    SignupFormFieldName.STREET_NUMBER,
                    (value) {
                      user.client!.address!.streetNumber = int.parse(value!);
                    },
                    user.client!.address!.streetNumber!.toString(),
                  ),
                  formTextField(
                    SignupFormFieldName.NEIGHBOUR,
                    (value) {
                      var auxValue = value!.split(" ");
                      value = "";
                      for (int i = 0; i < auxValue.length; i++) {
                        auxValue[i] =
                            "${auxValue[i].substring(0, 1).toUpperCase()}${auxValue[i].substring(1).toLowerCase()}";
                        value = i == 0 ? auxValue[i] : "$value ${auxValue[i]}";
                      }

                      user.client!.address!.neighbour = value;
                    },
                    user.client!.address!.neighbour!,
                  ),
                  formTextField(
                    SignupFormFieldName.CITY,
                    (value) {
                      user.client!.address!.city = "${value!.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
                    },
                    user.client!.address!.city!,
                  ),
                  formTextField(
                    SignupFormFieldName.DISTRICT,
                    (value) {
                      user.client!.address!.district = value;
                    },
                    user.client!.address!.district!,
                  ),
                  formTextField(
                    SignupFormFieldName.ZIPCODE,
                    (value) {
                      user.client!.address!.cep = value;
                    },
                    user.client!.address!.cep!,
                  ),
                  formTextField(
                    SignupFormFieldName.EMAIL,
                    (value) {
                      user.email = value;
                    },
                    user.email!,
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

  Widget formTextField(
      String text, void Function(String?) onSaved, String initialValue) {
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
