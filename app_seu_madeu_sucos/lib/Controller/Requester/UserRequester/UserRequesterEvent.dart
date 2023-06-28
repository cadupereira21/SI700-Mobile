import '../../../Model/UserModel.dart';

abstract class UserRequesterEvent {}

class CreateUserRequest extends UserRequesterEvent {
  UserModel user;
  CreateUserRequest(this.user);
}

class GetUserRequest extends UserRequesterEvent {
  String? userId;
  GetUserRequest({required this.userId});
}

class UpdateUserRequest extends UserRequesterEvent {
  String userId;
  UserModel user;
  UpdateUserRequest({required this.userId, required this.user});
}

class DeleteUserRequest extends UserRequesterEvent {
  String userId;
  DeleteUserRequest({required this.userId});
}
