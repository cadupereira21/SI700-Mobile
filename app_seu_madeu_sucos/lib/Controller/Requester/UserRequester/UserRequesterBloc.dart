import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UserRequesterEvent.dart';
import '../RequestState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, RequestState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUser>((event, emit) => _createUserRequest(event, emit));
  }

  void _createUserRequest(CreateUser event, Emitter emit) async {
    emit(ProcessingRequest());
    try{
        await service.createUser(event.user);
        emit(RequestSuccess(message: "Usuário criado com sucesso!"));
    } catch (exception){
      emit(RequestFailed(message: exception.toString()));
    }
  }
}
