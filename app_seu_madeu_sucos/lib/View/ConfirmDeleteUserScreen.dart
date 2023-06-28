import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Requester/UserRequester/UserRequesterBloc.dart';
import '../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../Data/UserData.dart';
import 'UserProfileScreen.dart';

class ConfirmDeleteUserScreen extends StatelessWidget {
  const ConfirmDeleteUserScreen({super.key});

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
              "Você deseja realmente excluir a sua conta?",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    BlocProvider.of<UserRequesterBloc>(context)
                        .add(DeleteUserRequest(userId: UserData.instance.id));
                    Navigator.pop(context);
                    AuthRequesterBloc authBloc =
                        BlocProvider.of<AuthRequesterBloc>(context);
                    authBloc.add(SignOutRequest());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Sim"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Não"),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
