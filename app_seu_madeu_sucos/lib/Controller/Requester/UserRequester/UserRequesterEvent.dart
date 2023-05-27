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
  User user;
  UpdateUserRequest(this.user);
}
