import 'package:app_seu_madeu_sucos/Data/UserData.dart';
import 'package:app_seu_madeu_sucos/Model/User.dart';
import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Service/RequestStatus.dart';
import 'UserMonitorEvent.dart';
import 'UserMonitorState.dart';

class UserMonitorBloc extends Bloc<UserMonitorEvent, UserMonitorState> {
  var serviceStreamController = UserServiceImp.instance.stream;
  UserMonitorBloc(super.initialState) {
    serviceStreamController.listen((event) {
      _listenToStream(event);
    });

    on<UpdateUserDataEvent>((event, emit) {
      emit(UserMonitorState(user: event.user));
    });
  }

  _listenToStream(event) {
    String? requestTitle = event[0];
    switch (requestTitle) {
      case (UserServiceImp.REQ_TITLE_CREATE_USER):
        break;
      case (UserServiceImp.REQ_TITLE_GET_USER):
        _listenToGetUserRequestResponse(event);
        break;
    }
  }

  void _listenToGetUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    List<Object> obj = event[2];
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(UpdateUserDataEvent(user: obj[0] as User));
    } else {
      print("Erro no UserMonitorBloc - ${RequestStatus.FAILED.toString()}");
    }
  }
}
