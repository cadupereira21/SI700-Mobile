import 'package:app_seu_madeu_sucos/Controller/Screen/Bloc/AccessController/AccessState.dart';
import 'package:app_seu_madeu_sucos/View/Signup/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Controller/Screen/Bloc/AccessController/AccessBloc.dart';
import 'Controller/Screen/Bloc/CartController/CartBloc.dart';
import 'Controller/Screen/Bloc/CartController/CartState.dart';
import '/View/Login/LoginPage.dart';
import '/View/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AccessBloc(LogInState())),
        BlocProvider(create: (BuildContext context) => CartBloc(CartState())),

      ],
      child: BlocBuilder<AccessBloc, AccessState>(
        builder: (context, authState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: switchPage(authState),
          );
        }
      ),
    );
  }
}

Widget switchPage(AccessState state){
  if (state is LogInState) {
    return const LoginPage(title: 'Login Page');
  } else if (state is LoggedInState) {
    return const HomePage(title: 'Home Page');
  } else if (state is SignUpState) {
    return const SignUpScreen();
  } else {
    return Container();
  }
}