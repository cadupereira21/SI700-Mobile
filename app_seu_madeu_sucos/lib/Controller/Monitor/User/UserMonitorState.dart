import '../../../Model/UserModel.dart';

class UserMonitorState {
  UserModel? user;
  UserMonitorState({this.user});
}

class LogInState extends UserMonitorState {
  LogInState({UserModel? user}) : super(user: user);
}

class LoggedInState extends UserMonitorState {
  LoggedInState({UserModel? user}) : super(user: user);
}

class SignUpState extends UserMonitorState {
  SignUpState({UserModel? user}) : super(user: user);
}

class SignUpFailedState extends UserMonitorState {
  String message;
  SignUpFailedState({required this.message, UserModel? user}) : super(user: user);
}
