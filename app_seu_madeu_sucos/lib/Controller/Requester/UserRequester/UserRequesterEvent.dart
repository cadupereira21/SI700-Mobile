import '../../../Model/User.dart';

abstract class UserRequesterEvent {}

class CreateUserEvent extends UserRequesterEvent {
  User user;
  CreateUserEvent(this.user);
}
