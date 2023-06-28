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