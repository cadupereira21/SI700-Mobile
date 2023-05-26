import 'package:app_seu_madeu_sucos/Data/UserData.dart';
import 'package:app_seu_madeu_sucos/Model/User.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Service/RequestStatus.dart';
import '../../../../Service/UserServiceImp.dart';
import 'AccessEvent.dart';
import 'AccessState.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  var serviceStreamController = UserServiceImp.instance.stream;
  AccessBloc(AccessState initialState) : super(initialState) {
    serviceStreamController.listen((event) {
      listenToStream(event);
    });

    on<LogInButtonClick>((event, emit) => {emit(LoggedInState())});
    on<IWantToSignUpButtonClick>(((event, emit) => emit(SignUpState())));
    on<SignUpRequestSuccessfulEvent>(((event, emit) {
      UserData.instance.setEmail(event.userEmail);
      emit(LoggedInState());
    }));
    on<CancelSignUpButtonClick>(((event, emit) => emit(LogInState())));
    on<SignUpRequestFailedEvent>((event, emit) {
      emit(SignUpFailedState(
          message: "Houve um problema na criação do cadastro!"));
      print((state as SignUpFailedState).message);
    });
  }

  listenToStream(event) {
    String? requestTitle = event[0];
    switch (requestTitle) {
      case (UserServiceImp.REQ_TITLE_CREATE_USER):
        listenToCreateUserRequestResponse(event);
        break;
    }
  }

  listenToCreateUserRequestResponse(event) {
    RequestStatus requestStatus = event[1];
    List<Object> obj = event[2];
    if (requestStatus == RequestStatus.SUCCESSFUL) {
      add(SignUpRequestSuccessfulEvent(userEmail: (obj[0] as User).email));
    } else {
      add(SignUpRequestFailedEvent());
    }
  }
}
