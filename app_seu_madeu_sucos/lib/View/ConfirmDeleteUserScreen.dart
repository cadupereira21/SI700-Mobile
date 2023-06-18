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
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: MediaQuery.of(context).size.height*0.35),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly  ,
            children: [
              const Text("Você deseja realmente excluir a sua conta?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      BlocProvider.of<UserRequesterBloc>(context)
                          .add(DeleteUserRequest(userId: UserData.instance.id));
                    }, 
                    child: const Text("Sim"),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfileScreen()),
                      );
                    }, 
                    child: const Text("Não"),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}