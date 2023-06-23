import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterState.dart';
import 'package:app_seu_madeu_sucos/View/UserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserInfoErrorScreen extends StatelessWidget {
  const UpdateUserInfoErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 80, vertical: MediaQuery.of(context).size.height * 0.37),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Ocorreu um erro durante a atualização das informações do usuário",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              "Descrição: <MensagemDeErro>",
              style:
                  TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.7)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: ((context) => const UserProfileScreen())));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Ok"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
