import 'package:app_seu_madeu_sucos/Model/UserModel.dart';

class AuthRequesterEvent {}

class CompleteAuthRequest extends AuthRequesterEvent {}

class AuthenticateRequest extends AuthRequesterEvent {
  UserModel user;
  AuthenticateRequest({required this.user});
}

class UnauthenticateRequest extends AuthRequesterEvent {}