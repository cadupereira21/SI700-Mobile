import '../../../Model/User.dart';

abstract class UserRequesterEvent {}

class CreateUser extends UserRequesterEvent {
  User user;
  CreateUser(this.user);
}
