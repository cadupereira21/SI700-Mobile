import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UserRequesterEvent.dart';
import 'UserRequesterState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, UserRequesterState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUserRequest>((event, emit) => _createUserRequest(event, emit));
    on<GetUserRequest>((event, emit) => _getUserRequest(event, emit));
    on<UpdateUserRequest>((event, emit) => _updateUserRequest(event, emit));
    on<DeleteUserRequest>((event, emit) => _deleteUserRequest(event, emit));
    on<CompleteUserRequest>((event, emit) => emit(WaitingUserRequestState()),);
  }

  void _createUserRequest(CreateUserRequest event, Emitter emit) async {
    emit(ProcessingUserRequestState());
    debugPrint("[User Requester] Sending create user request");

    await service.createUser(event.user);

    add(CompleteUserRequest());
    debugPrint("[User Requester] Complete create user request");
  }

  _getUserRequest(GetUserRequest event, Emitter emit) async {
    emit(ProcessingUserRequestState());

    debugPrint("[User Requester] Sending get user request");

    await service.getUserById(event.userId);

    add(CompleteUserRequest());
    debugPrint("[User Requester] Complete get user request");
  }

  _updateUserRequest(
      UpdateUserRequest event, Emitter emit) async {
    emit(ProcessingUserRequestState());
    debugPrint("[User Requester] Sending update user request");

    await service.updateUser(event.userId, event.user);

    add(CompleteUserRequest());
    debugPrint("[User Requester] Complete update user request");
  }

  _deleteUserRequest(
      DeleteUserRequest event, Emitter emit) async {
    emit(ProcessingUserRequestState());
    debugPrint("[User Requester] Sending delete user request");

    await service.deleteUser(event.userId);

    add(CompleteUserRequest());
    debugPrint("[User Requester] Complete delete user request");
  }
}
