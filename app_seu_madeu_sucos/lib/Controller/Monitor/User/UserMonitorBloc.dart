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
    on<SignUpRequestSuccessful>(((event, emit) {
      UserData.instance.setId(event.userId!);
      UserData.instance.setUser(event.user!);
      emit(LoggedInState());
    }));
    on<SignUpRequestFailed>((event, emit) {
      emit(SignUpFailedState(
          message: "Houve um problema na criação do cadastro!"));
      debugPrint((state as SignUpFailedState).message);
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
    List<Object> obj = event[2];
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(SignUpRequestSuccessful(
          userId: obj[0].toString(), user: (obj[1] as UserModel)));
    } else {
      add(SignUpRequestFailed());
    }
  }
}
