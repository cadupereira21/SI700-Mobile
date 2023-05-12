import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: Column(
          children: [
            const Text("Tela de perfil do usuário"),
            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text("Voltar"))
          ],
        ),
      ),
    );
  }
}
