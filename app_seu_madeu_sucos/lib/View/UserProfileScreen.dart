import 'package:app_seu_madeu_sucos/Controller/Requester/RequestState.dart';
import 'package:app_seu_madeu_sucos/View/UpdateUserInfoErrorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Controller/Requester/UserRequester/UserRequesterState.dart';
import '../Data/UserData.dart';
import '../Model/Districts.dart';
import '../Model/User.dart';
import 'ConfirmDeleteUserScreen.dart';
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
  String _dropdownValue = UserData.instance.user.client!.address!.district!;
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
                    inputType: TextInputType.name,
                    initialValue: user.client!.name!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      } else if (TextFormFieldFormat.checkIfStringHasNumber(
                              value) ||
                          TextFormFieldFormat.checkIfStringHasSpecialCharacters(
                              value)) {
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
                    mask: TextFormFieldFormat.PHONE,
                    inputType: TextInputType.phone,
                    initialValue: user.client!.phone!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira seu número de telefone";
                      } else if (value.length < 16) {
                        return "Número incompleto!";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.client!.phone = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.STREET,
                    initialValue: user.client!.address!.street!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira seu endereço";
                      }
                      return null;
                    },
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
                    initialValue:
                        user.client!.address!.streetNumber!.toString(),
                    mask: TextFormFieldFormat.STREET_NUMBER,
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira o número do seu endereço";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.client!.address!.streetNumber = int.parse(value!);
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.NEIGHBOUR,
                    initialValue: user.client!.address!.neighbour!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira seu bairro";
                      }
                      return null;
                    },
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
                  dropdownButton(),
                  formTextField(
                    text: SignupFormFieldName.CITY,
                    initialValue: user.client!.address!.city!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira sua cidade";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.client!.address!.city =
                          "${value!.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.ZIPCODE,
                    initialValue: user.client!.address!.cep!,
                    mask: TextFormFieldFormat.ZIPCODE,
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor insira o seu CEP";
                      } else if (value.length < 9) {
                        return "CEP incompleto";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.client!.address!.cep = value;
                    },
                  ),
                  formTextField(
                    text: SignupFormFieldName.EMAIL,
                    initialValue: user.email!,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email';
                      } else if (!value.contains("@") || !value.contains(".")) {
                        return "Por favor insira um email válido!";
                      }
                      return null;
                    },
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

  Widget dropdownButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField(
        value: _dropdownValue,
        decoration: const InputDecoration(labelText: "UF"),
        items: Districts.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onSaved: (value) {
          user.client!.address!.district = value;
        },
        onChanged: (value) {
          setState(() {
            _dropdownValue = value!;
          });
        },
      ),
    );
  }

  Widget formTextField({
    required String text,
    required String initialValue,
    MaskTextInputFormatter? mask,
    TextInputType? inputType,
    required void Function(String?) onSaved,
    String? Function(String?)? validator,
  }) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          initialValue: initialValue,
          inputFormatters: mask != null ? [mask] : [],
          keyboardType: inputType ?? TextInputType.text,
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
            } else if (value.length < 8) {
              return "Sua senha deverá conter no mínimo 8 caracteres";
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
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConfirmDeleteUserScreen()),
            );
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

      var userRequesterBloc = BlocProvider.of<UserRequesterBloc>(context);
      userRequesterBloc
          .add(UpdateUserRequest(userId: UserData.instance.id, user: user));

      if (userRequesterBloc.state is RequestSuccess) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text("Informações atualizadas com sucesso"),
          action: SnackBarAction(
            label: "Ok",
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            },
          ),
        ));
      } else if (userRequesterBloc.state is RequestFailed) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateUserInfoErrorScreen()));
      }
    }
  }
}
