import '../../../Model/User.dart';

class UserMonitorState {
  User? user;
  UserMonitorState({this.user});
}

class LogInState extends UserMonitorState {
  LogInState({User? user}) : super(user: user);
}

class LoggedInState extends UserMonitorState {
  LoggedInState({User? user}) : super(user: user);
}

class SignUpState extends UserMonitorState {
  SignUpState({User? user}) : super(user: user);
}

class SignUpFailedState extends UserMonitorState {
  String message;
  SignUpFailedState({required this.message, User? user}) : super(user: user);
}
