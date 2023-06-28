import 'package:app_seu_madeu_sucos/Controller/Requester/RequestState.dart';
import 'package:app_seu_madeu_sucos/View/UpdateUserInfoErrorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Data/UserData.dart';
import '../Model/Districts.dart';
import '../Model/UserModel.dart';
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
  UserModel user = UserData.instance.user;
  String _dropdownValue = UserData.instance.user.getClient.getAddress.getDistrict;
  //var clientAddress = UserData.instance.user.getClient.address!;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações da conta"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.fromLTRB(screenWidth*0.04, 0, screenWidth*0.04, 0),
            child: Column(
              children: [
                formTextField(
                  text: SignupFormFieldName.NAME,
                  inputType: TextInputType.name,
                  initialValue: user.getClient.getName,
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
                    user.getClient.setName = value!;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.PHONE,
                  mask: TextFormFieldFormat.PHONE,
                  inputType: TextInputType.phone,
                  initialValue: user.getClient.getPhone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira seu número de telefone";
                    } else if (value.length < 16) {
                      return "Número incompleto!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.getClient.setPhone = value!;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.STREET,
                  initialValue: user.getClient.getAddress.getStreet,
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
    
                    user.getClient.getAddress.setStreet = value!;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.STREET_NUMBER,
                  initialValue:
                      user.getClient.getAddress.getStreetNumber.toString(),
                  mask: TextFormFieldFormat.STREET_NUMBER,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira o número do seu endereço";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.getClient.getAddress.setStreetNumber = int.parse(value!);
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.NEIGHBOUR,
                  initialValue: user.getClient.getAddress.getNeighbour,
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
    
                    user.getClient.getAddress.setNeighbour = value!;
                  },
                ),
                dropdownButton(),
                formTextField(
                  text: SignupFormFieldName.CITY,
                  initialValue: user.getClient.getAddress.getCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira sua cidade";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.getClient.getAddress.setCity =
                        "${value!.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.ZIPCODE,
                  initialValue: user.getClient.getAddress.getCep,
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
                    user.getClient.getAddress.setCep = value!;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.EMAIL,
                  initialValue: user.getEmail,
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
                    user.setEmail = value!;
                  },
                ),
                formNewPasswordField(),
                deleteUserButton(),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight*0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      formButton("Voltar", () {
                        Navigator.pop(context);
                      }),
                      formButton("Salvar", _updateAction),
                    ],
                  ),
                ),
              ],
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
          user.getClient.getAddress.setDistrict = value!;
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
            UserData.instance.user.setPassword = value!;
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
              try {
                ScaffoldMessenger.of(context).clearSnackBars();
              } catch (e) {
                print(e.toString());
              }
            },
          ),
        ));
      } else if (userRequesterBloc.state is RequestFailed) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateUserInfoErrorScreen()));
      }
    }
  }
}
