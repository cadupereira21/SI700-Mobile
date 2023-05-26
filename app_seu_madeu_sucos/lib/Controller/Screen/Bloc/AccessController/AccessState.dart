abstract class AccessState {}

class LogInState extends AccessState {
  LogInState() {}
}

class LoggedInState extends AccessState {
  LoggedInState() {}
}

class SignUpState extends AccessState {
  SignUpState() {}
}

class SignUpFailedState extends AccessState {
  String message;
  SignUpFailedState({required this.message});
}
