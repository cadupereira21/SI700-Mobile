import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/Authentication/AuthRequesterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Service/AuthServiceImp.dart';

class AuthRequesterBloc extends Bloc<AuthRequesterEvent, AuthRequesterState>{
  final _service = AuthServiceImp.instance;

  AuthRequesterBloc(super.initialState){
    on<CompleteAuthRequest>((event, emit) => emit(WaitingAuthRequestState()),);
    on<AuthenticateRequest>((event, emit) {
        _authenticate(event, emit);
      },
    );
    on<SignOutRequest>((event, emit) => _signOut(event, emit));
  }
  
  Future<void> _authenticate(AuthenticateRequest event, Emitter emit) async {
    emit(ProcessingAuthRequestState());
    debugPrint("[Auth Requester] Starting authenticate request");

    await _service.authenticate(event.user);

    add(CompleteAuthRequest());
    debugPrint("[Order Requester] Complete authenticate request");
  }
  
  _signOut(SignOutRequest event, Emitter emit) async {
    emit(ProcessingAuthRequestState());
    debugPrint("[Auth Requester] Starting sign out request");

    await _service.signOut();

    add(CompleteAuthRequest());
    debugPrint("[Order Requester] Complete sign out request");
  }
}