import 'package:app_seu_madeu_sucos/Controller/Monitor/Auth/AuthMonitorEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Auth/AuthMonitorState.dart';
import 'package:app_seu_madeu_sucos/Data/NewOrderData.dart';
import 'package:app_seu_madeu_sucos/Data/OrderCollectionData.dart';
import 'package:app_seu_madeu_sucos/Data/ProductData.dart';
import 'package:app_seu_madeu_sucos/Model/UserModel.dart';
import 'package:app_seu_madeu_sucos/Service/AuthServiceImp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/CartData.dart';
import '../../../Data/UserData.dart';
import '../../../Service/RequestStatus.dart';

class AuthMonitorBloc extends Bloc<AuthMonitorEvent, AuthMonitorState> {
  final _streamController = AuthServiceImp.instance.stream;

  AuthMonitorBloc(super.initialState){
    _streamController.listen((event) {
      debugPrint("[Auth Monitor] Received an event: ${event[0]}");

      switch (event[0]) {
        case AuthServiceImp.REQ_TITLE_AUTHENTICATE:
          _listenToAuthenticate(event);
          break;
        case AuthServiceImp.REQ_TITLE_SIGNOUT:
          _listenToSignOut(event);
          break;
        case AuthServiceImp.REQ_TITLE_CREATE_USER:
          _listenToCreateAuthUser(event);
          break;
        default:
          break;
      }
    });

    on<Authenticate>((event, emit) {
        debugPrint("[Auth Monitor] Authenticated");
        UserData.instance.setUser(event.user);
        emit(AuthenticatedState());
      },
    );

    on<Unauthenticate>((event, emit) {
      debugPrint("[Auth Monitor] Unauthenticated");
      emit(UnauthenticatedState());
    });

    on<ListenToAuthenticateRequestSuccessful>((event, emit) {
      debugPrint("[Auth Monitor] Authenticate request successful");
      UserData.instance.setUser(event.user);
      emit(AuthenticateRequestSuccessful());
      add(Authenticate(user: event.user));
    },);

    on<ListenToAuthenticateRequestFailed>((event, emit) {
      emit(AuthenticateRequestFailed(message: "Usuário ou senha incorretos"));
      add(Unauthenticate());
    },);

    on<SignOutRequestSuccessful>((event, emit) {
      debugPrint("[Auth Monitor] Signed Out");
      CartData.instance.clearData();
      NewOrderData.instance.clearData();
      ProductData.instance.clearProducts();
      OrderCollectionData.instance.clearOrders();
      UserData.instance.clearData();
      emit(UnauthenticatedState(message: "Usuário saiu com sucesso"));
    },);

    on<SignOutRequestFailed>((event, emit) {
      debugPrint("[Auth Monitor] Sign Out failed! Description: ${event.message}");
      emit(AuthenticatedState(message: "Falha no logout! Descrição: ${event.message}"));
    },);

    on<CreateUserRequestSuccessful>((event, emit) {
      debugPrint("[Auth Monitor] Auth User Created");
      emit(AuthenticatedState());
    },);

    on<CreateUserRequestFailed>((event, emit) {
      debugPrint("[Auth Monitor] Create auth user failed! Description: ${event.message}");
      emit(UnauthenticatedState(message: "Falha na criação do usuário! Descrição: ${event.message}"));
    },);
  }
  
  void _listenToAuthenticate(event) {
    RequestStatus responseStatus = event[1];

    if (responseStatus == RequestStatus.SUCCESSFUL) {
      UserModel user = event[2][0] as UserModel;
      add(ListenToAuthenticateRequestSuccessful(user: user));
    } else {
      add(ListenToAuthenticateRequestFailed());
    }
  }
  
  void _listenToSignOut(event) {
    RequestStatus responseStatus = event[1];

    if (responseStatus == RequestStatus.SUCCESSFUL) {
      add(SignOutRequestSuccessful());
    } else {
      String message = event[2][0].toString();
      add(SignOutRequestFailed(message: message));
    }
  }
  
  void _listenToCreateAuthUser(event) {
    RequestStatus responseStatus = event[1];

    if (responseStatus == RequestStatus.SUCCESSFUL) {
      UserModel user = event[2][0] as UserModel;
      add(CreateUserRequestSuccessful(user: user));
    } else {
      String message = event[2][0].toString();
      add(CreateUserRequestFailed(message: message));
    }
  }
}