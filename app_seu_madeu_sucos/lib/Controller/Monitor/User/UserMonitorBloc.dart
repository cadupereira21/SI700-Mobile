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
      debugPrint("[User Monitor] Received an event: ${event[0]}");

      _listenToStream(event);
    });
    on<ListenToCreateUserRequestSuccessful>(((event, emit) {
      debugPrint("[User Monitor] Create user successful");
      UserData.instance.setId(event.userId!);
      UserData.instance.setUser(event.user!);
      emit(UserRequestSuccesful(user: event.user!));
    }));
    on<ListenToCreateUserRequestFailed>((event, emit) {
      debugPrint("[User Monitor] Create user Failed");
      emit(UserRequestFailed(
          message: "Houve um problema na criação do cadastro!"));
    });
  }

  _listenToStream(event) {
    String? requestTitle = event[0];
    switch (requestTitle) {
      case (UserServiceImp.REQ_TITLE_CREATE_USER):
        _listenToCreateUserRequestResponse(event);
        break;
    }
  }

  _listenToCreateUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    String userId = event[2][0].toString();
    UserModel user = event[2][1] as UserModel;
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(ListenToCreateUserRequestSuccessful(
          user: user, userId: userId));
    } else {
      add(ListenToCreateUserRequestFailed());
    }
  }
}
