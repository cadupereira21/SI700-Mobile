import 'package:flutter/material.dart';

import 'LoginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'lib/Assets/seuMadeu.jpeg',
              height: 250,
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}
