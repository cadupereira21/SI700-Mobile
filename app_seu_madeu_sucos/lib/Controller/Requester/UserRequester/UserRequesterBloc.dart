import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../RequestState.dart';
import 'UserRequesterEvent.dart';
import 'UserRequesterState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, RequestState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUserEvent>((event, emit) => _createUserRequest(event, emit));
  }

  void _createUserRequest(CreateUserEvent event, Emitter emit) async {
    emit(ProcessingUserRequest());
    try {
      await service.createUser(event.user);
      emit(RequestSuccess(message: "Usuário criado com sucesso!"));
      print((state as RequestSuccess).message);
    } catch (exception) {
      emit(RequestFailed(message: exception.toString()));
      print(exception.toString());
    }
  }
}
