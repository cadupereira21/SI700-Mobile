import '../../../Model/UserModel.dart';

class UserMonitorState {
  String? message;
  UserModel? user;
  UserMonitorState({this.message, this.user});
}

class UserRequestSuccesful extends UserMonitorState {
  UserRequestSuccesful(
      {super.message, super.user});
}

class UserRequestFailed extends UserMonitorState {
  UserRequestFailed({super.message, super.user});
}
