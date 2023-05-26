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
    on<LogInButtonClick>((event, emit) => {emit(LoggedInState())});
    on<IWantToSignUpButtonClick>(((event, emit) => emit(SignUpState())));
    on<SignUpRequestSuccessfulEvent>(((event, emit) {
      UserData.instance.setId(event.userId);
      UserData.instance.setUser(event.user);
      emit(LoggedInState());
    }));
    on<CancelSignUpButtonClick>(((event, emit) => emit(LogInState())));
    on<SignUpRequestFailedEvent>((event, emit) {
      emit(SignUpFailedState(
          message: "Houve um problema na criação do cadastro!"));
      print((state as SignUpFailedState).message);
    });
  }

  _listenToStream(event) {
    String? requestTitle = event[0];
    switch (requestTitle) {
      case (UserServiceImp.REQ_TITLE_CREATE_USER):
        _listenToCreateUserRequestResponse(event);
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

  _listenToCreateUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    List<Object> obj = event[2];
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(SignUpRequestSuccessfulEvent(userId: obj[0].toString(), user: (obj[1] as User)));
    } else {
      add(SignUpRequestFailedEvent());
    }
  }
}
