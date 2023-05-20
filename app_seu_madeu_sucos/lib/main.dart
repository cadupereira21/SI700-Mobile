import 'package:app_seu_madeu_sucos/Front/View/Widgets/Signup/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Back/Controller/Authenticate/AuthBloc.dart';
import 'Back/Controller/Authenticate/AuthState.dart';
import 'Front/Bloc/CartController/CartBloc.dart';
import 'Front/Bloc/CartController/CartState.dart';
import 'Front/View/Widgets/Login/LoginPage.dart';
import 'Front/View/Widgets/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthBloc(NotLoggedIn())),
        BlocProvider(create: (BuildContext context) => CartBloc(CartState())),

      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: authState.isLoggedIn?
              const HomePage(title: 'Home Page')
              :(authState is SignUpState?
                const SignUpScreen()
                :const LoginPage(title: 'Login Page')
              ),
          );
        }
      ),
    );
  }
}

