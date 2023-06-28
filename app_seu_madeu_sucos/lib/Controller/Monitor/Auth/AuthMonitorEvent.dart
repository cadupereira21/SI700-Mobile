import 'package:app_seu_madeu_sucos/Model/UserModel.dart';

class AuthMonitorEvent {}

class Authenticate extends AuthMonitorEvent {
  UserModel user;
  Authenticate({required this.user});
}

class Unauthenticate extends AuthMonitorEvent {

}

class ListenToAuthenticateRequestSuccessful extends AuthMonitorEvent {
  UserModel user;
  ListenToAuthenticateRequestSuccessful({required this.user});
}

class ListenToAuthenticateRequestFailed extends AuthMonitorEvent {
  ListenToAuthenticateRequestFailed();
}

class SignOutRequestSuccessful extends AuthMonitorEvent {}

class SignOutRequestFailed extends AuthMonitorEvent {
  String message = "<SignOutFailedMessage>";
  SignOutRequestFailed({required this.message});
}

class CreateUserRequestSuccessful extends AuthMonitorEvent {
  UserModel user;
  CreateUserRequestSuccessful({required this.user});
}

class CreateUserRequestFailed extends AuthMonitorEvent {
  String message = "<AuthFailedMessage>";
  CreateUserRequestFailed({required this.message});
}