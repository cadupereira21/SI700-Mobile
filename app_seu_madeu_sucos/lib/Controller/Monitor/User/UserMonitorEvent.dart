import '../../../Model/UserModel.dart';

abstract class UserMonitorEvent {
  String? message;
  UserMonitorEvent({this.message});
}

class ListenToCreateUserRequestSuccessful extends UserMonitorEvent {
  String? userId;
  UserModel? user;
  ListenToCreateUserRequestSuccessful({this.userId, this.user});
}

class ListenToCreateUserRequestFailed extends UserMonitorEvent {
  ListenToCreateUserRequestFailed();
}

