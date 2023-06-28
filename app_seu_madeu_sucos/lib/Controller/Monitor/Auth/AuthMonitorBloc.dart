import 'package:app_seu_madeu_sucos/Controller/Monitor/Auth/AuthMonitorEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Auth/AuthMonitorState.dart';
import 'package:app_seu_madeu_sucos/Model/UserModel.dart';
import 'package:app_seu_madeu_sucos/Service/AuthServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/UserData.dart';
import '../../../Service/RequestStatus.dart';

class AuthMonitorBloc extends Bloc<AuthMonitorEvent, AuthMonitorState> {
  final _streamController = AuthServiceImp.instance.stream;

  AuthMonitorBloc(super.initialState){
    _streamController.listen((event) {
      debugPrint("[Auth Monitor] Received an event: ${event[0]}");

      switch (event[0]) {
        case AuthServiceImp.REQ_TITLE_AUTHENTICATE:
          _listenToAuthenticate(event);
          break;
        default:
          break;
      }
    });

    on<AuthenticateRequestSuccessful>((event, emit) {
        debugPrint("[Auth Monitor] Authenticated");
        UserData.instance.setUser(event.user);
        emit(AuthenticatedState());
      },
    );

    on<AuthenticateRequestFailed>((event, emit) {
      debugPrint("[Auth Monitor] Authentication failed");
      emit(UnauthenticatedState(message: "Falha na autenticação! Descrição: ${event.message}"));
    });
  }
  
  void _listenToAuthenticate(event) {
    RequestStatus responseStatus = event[1];

    if (responseStatus == RequestStatus.SUCCESSFUL) {
      UserModel user = event[2][0] as UserModel;
      add(AuthenticateRequestSuccessful(user: user));
    } else {
      String message = event[2][0].toString();
      add(AuthenticateRequestFailed(message: message));
    }
  }
  
}