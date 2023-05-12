import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Authenticate/AuthBloc.dart';
import 'Bloc/Authenticate/AuthState.dart';
import 'View/Widgets/Login/LoginPage.dart';
import 'View/Widgets/HomePage.dart';

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
              :const LoginPage(title: 'Login Page'),
          );
        }
      ),
    );
  }
}

