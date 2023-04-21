import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            Row(
              children: [
                ElevatedButton(onPressed: (){}, child: const Text("Log In")),
                ElevatedButton(onPressed: (){}, child: const Text("Log In")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
