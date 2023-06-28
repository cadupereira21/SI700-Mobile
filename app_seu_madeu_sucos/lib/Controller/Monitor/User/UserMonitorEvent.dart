import '../../../Model/UserModel.dart';

abstract class UserMonitorEvent {}

class SignUpRequestSuccessful extends UserMonitorEvent {
  String? userId;
  UserModel? user;
  SignUpRequestSuccessful({this.userId, this.user});
}

class SignUpRequestFailed extends UserMonitorEvent {
  SignUpRequestFailed();
}

