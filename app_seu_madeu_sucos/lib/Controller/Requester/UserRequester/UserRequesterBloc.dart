import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UserRequesterEvent.dart';
import 'UserRequesterState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, UserRequesterState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUser>((event, emit) => _createUserRequest(event, emit));
  }

  void _createUserRequest(CreateUser event, Emitter emit) {
    emit(ProcessingRequest());
    //Call Service.create(event.user)
    //if success emit success
    //else emit failed
  }
}
