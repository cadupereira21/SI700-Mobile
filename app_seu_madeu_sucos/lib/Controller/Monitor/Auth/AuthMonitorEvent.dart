import 'package:app_seu_madeu_sucos/Model/UserModel.dart';

class AuthMonitorEvent {}

class AuthenticateRequestSuccessful extends AuthMonitorEvent {
  UserModel user;
  AuthenticateRequestSuccessful({required this.user});
}

class AuthenticateRequestFailed extends AuthMonitorEvent {
  String message = "<AuthFailedMessage>";
  AuthenticateRequestFailed({required this.message});
}