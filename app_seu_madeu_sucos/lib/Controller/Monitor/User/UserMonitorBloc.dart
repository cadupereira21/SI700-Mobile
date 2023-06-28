import 'package:app_seu_madeu_sucos/Data/UserData.dart';
import 'package:app_seu_madeu_sucos/Model/UserModel.dart';
import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Service/RequestStatus.dart';
import 'UserMonitorEvent.dart';
import 'UserMonitorState.dart';

class UserMonitorBloc extends Bloc<UserMonitorEvent, UserMonitorState> {
  var serviceStreamController = UserServiceImp.instance.stream;
  UserMonitorBloc(super.initialState) {
    serviceStreamController.listen((event) {
      debugPrint("[user-monitor] Received an event: ${event[0]}");

      _listenToStream(event);
    });
    on<ListenToCreateUserRequestSuccessful>(((event, emit) {
      debugPrint("[user-monitor] Create user successful");
      UserData.instance.setUser(event.user!);
      emit(UserRequestSuccesful(user: event.user!));
    }));
    on<ListenToCreateUserRequestFailed>((event, emit) {
      debugPrint("[user-monitor] Create user Failed");
      emit(UserRequestFailed(
          message: "Houve um problema na criação do cadastro!"));
    });

    on<ListenToGetUserRequestSuccessful>((event, emit) {
      debugPrint("[user-monitor] Get user successful: ${event.user}");

      UserData.instance.setUser(event.user!);
      emit(UserRequestSuccesful(user: event.user!));
    },);
    on<ListenToGetUserRequestFailed>((event, emit) {
      debugPrint("[user-monitor] Get user Failed");
      emit(UserRequestFailed(
          message: "Houve um problema ao tentar buscar o usuário!"));
    });
  }

  _listenToStream(event) {
    String? requestTitle = event[0];
    switch (requestTitle) {
      case (UserServiceImp.REQ_TITLE_CREATE_USER):
        _listenToCreateUserRequestResponse(event);
        break;
      case UserServiceImp.REQ_TITLE_GET_USER:
        _listenToGetUserRequestResponse(event);
    }
  }

  _listenToCreateUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    String userId = event[2][0].toString();
    UserModel user = event[2][1] as UserModel;
    user.setId = userId;
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToCreateUserRequestSuccessful(
          user: user));
    } else {
      add(ListenToCreateUserRequestFailed());
    }
  }
  
  void _listenToGetUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    UserModel user = event[2][0] as UserModel;
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToGetUserRequestSuccessful(
          user: user));
    } else {
      add(ListenToGetUserRequestFailed());
    }
  }
}
