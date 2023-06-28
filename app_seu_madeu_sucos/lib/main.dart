import 'package:app_seu_madeu_sucos/Controller/Monitor/Order/OrderMonitorState.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Product/ProductMonitorState.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/User/UserMonitorBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/OrderRequester/OrderRequesterState.dart';
import 'package:app_seu_madeu_sucos/View/Signup/SignupScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Assets/CustomColor.dart';
import 'Controller/Monitor/Order/OrderMonitorBloc.dart';
import 'Controller/Monitor/Product/ProductMonitorBloc.dart';
import 'Controller/Monitor/User/UserMonitorState.dart';
import 'Controller/Requester/ProductRequester/ProductRequesterBloc.dart';
import 'Controller/Requester/RequestState.dart';
import 'Controller/Requester/UserRequester/UserRequesterBloc.dart';
import 'Controller/Screen/Bloc/CartController/CartBloc.dart';
import 'Controller/Screen/Bloc/CartController/CartState.dart';
import 'View/Login/LoginScreen.dart';
import '/View/HomePage.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CartBloc(CartState())),
        BlocProvider(create: (BuildContext context) => UserRequesterBloc(WaitingRequest())),
        BlocProvider(create: (BuildContext context) => UserMonitorBloc(LogInState())),
        BlocProvider(create: (BuildContext context) => ProductMonitorBloc(ProductMonitorState(productColletion: []))),
        BlocProvider(create: (BuildContext context) => ProductRequesterBloc(WaitingRequest())),
        BlocProvider(create: (BuildContext context) => OrderRequesterBloc(WaitingOrderRequestState())),
        BlocProvider(create: (BuildContext context) => OrderMonitorBloc(OrderMonitorState())),
      ],
      child: BlocBuilder<UserMonitorBloc, UserMonitorState>(
        builder: (context, authState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: CustomColor.getGreenColor(),
            ),
            home: LoginScreen(),
          );
        }
      ),
    );
  }
}

Widget switchPage(UserMonitorState state){
  if (state is LogInState) {
    return const LoginScreen();
  } else if (state is LoggedInState) {
    return const HomePage(title: 'Home Page');
  } else if (state is SignUpState) {
    return const SignUpScreen();
  } else {
    return Container();
  }
}