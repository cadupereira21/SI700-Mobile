import '../../../Model/User.dart';

abstract class UserRequesterEvent {}

class CreateUserRequest extends UserRequesterEvent {
  User user;
  CreateUserRequest(this.user);
}

class GetUserRequest extends UserRequesterEvent {
  String? userId;
  GetUserRequest({required this.userId});
}

class UpdateUserRequest extends UserRequesterEvent {
  String userId;
  User user;
  UpdateUserRequest({required this.userId, required this.user});
}

class DeleteUserRequest extends UserRequesterEvent {
  String userId;
  DeleteUserRequest({required this.userId});
}
