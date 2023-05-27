import 'package:app_seu_madeu_sucos/Service/UserServiceImp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/UserData.dart';
import '../RequestState.dart';
import 'UserRequesterEvent.dart';
import 'UserRequesterState.dart';

class UserRequesterBloc extends Bloc<UserRequesterEvent, RequestState> {
  UserServiceImp service = UserServiceImp.instance;

  UserRequesterBloc(super.initialState) {
    on<CreateUserRequest>((event, emit) => _createUserRequest(event, emit));
    on<GetUserRequest>(
      (event, emit) => _getUserRequest(event, emit)
    );
    on<UpdateUserRequest>(
      (event, emit) => _updateUserRequest(event, emit)
    );
  }

  void _createUserRequest(CreateUserRequest event, Emitter emit) async {
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

  _getUserRequest(GetUserRequest event, Emitter<RequestState> emit) async {
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

  _updateUserRequest(UpdateUserRequest event, Emitter<RequestState> emit){
    emit(ProcessingUserRequest());

    try {
      //await service.updateUser(event.user);
      emit(RequestSuccess(message: "Usuário atualizado com sucesso!"));
      print((state as RequestSuccess).message);
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
      print(e.toString());
    }
  }
}
