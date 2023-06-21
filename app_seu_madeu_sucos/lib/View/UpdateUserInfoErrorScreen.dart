import 'package:flutter/material.dart';

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
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.7)
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
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