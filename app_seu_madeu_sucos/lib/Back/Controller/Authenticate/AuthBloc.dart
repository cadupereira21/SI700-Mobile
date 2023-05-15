import 'package:app_seu_madeu_sucos/Back/Controller/Authenticate/AuthEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<LogIn>((event, emit) => emit(LoggedIn()));
    on<LogOut>((event, emit) => emit(NotLoggedIn()));
  }
}