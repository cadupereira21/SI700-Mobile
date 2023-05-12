import 'package:flutter/material.dart';

class UserPlanScreen extends StatefulWidget {
  const UserPlanScreen({super.key});

  @override
  State<UserPlanScreen> createState() => _UserPlanScreenState();
}

class _UserPlanScreenState extends State<UserPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: Column(
          children: [
            const Text("Tela de planos da loja"),
            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text("Voltar"))
          ],
        ),
      ),
    );
  }
}
