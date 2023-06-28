import '../../../Model/UserModel.dart';

abstract class UserMonitorEvent {
  String? message;
  UserMonitorEvent({this.message});
}

class ListenToCreateUserRequestSuccessful extends UserMonitorEvent {
  UserModel? user;
  ListenToCreateUserRequestSuccessful({this.user});
}

class ListenToCreateUserRequestFailed extends UserMonitorEvent {
  ListenToCreateUserRequestFailed();
}

class ListenToGetUserRequestSuccessful extends UserMonitorEvent {
  UserModel? user;
  ListenToGetUserRequestSuccessful({this.user});
}

class ListenToGetUserRequestFailed extends UserMonitorEvent {
  ListenToGetUserRequestFailed();
}
