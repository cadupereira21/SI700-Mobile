import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/UserData.dart';
import '../RequestState.dart';
import 'UserRequesterEvent.dart';
import 'UserRequesterState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, RequestState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUserEvent>((event, emit) => _createUserRequest(event, emit));
    on<GetUserEvent>(
      (event, emit) => _getUserRequest(event, emit),
    );
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

  _getUserRequest(GetUserEvent event, Emitter<RequestState> emit) async {
    emit(ProcessingUserRequest());

    try {
      await service.getUserById(event.userId);
      emit(RequestSuccess(message: "Usuário encontrado com sucesso!"));
      print((state as RequestSuccess).message);
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
      print(e.toString());
    }
  }
}
