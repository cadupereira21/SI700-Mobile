import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AuthController.dart';
import 'AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<LogIn>((event, emit) => {
      if(AuthController.instance.login(event.user)){
        emit(LoggedIn())
      } else{
        // Criar evento para o caso de login falhar
        emit(NotLoggedIn())
      }
    });
    on<LogOut>((event, emit) => emit(NotLoggedIn()));
    on<SignUp>(((event, emit) => emit(SignUpState())));
  }
}