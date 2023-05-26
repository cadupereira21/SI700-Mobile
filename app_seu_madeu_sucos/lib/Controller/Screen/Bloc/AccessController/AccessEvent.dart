abstract class AccessEvent {}

class LogInButtonClick extends AccessEvent {
  LogInButtonClick();
}

class IWantToSignUpButtonClick extends AccessEvent {
  IWantToSignUpButtonClick();
}

class SignUpRequestSuccessfulEvent extends AccessEvent {
  String? userEmail;
  SignUpRequestSuccessfulEvent({this.userEmail});
}

class SignUpRequestFailedEvent extends AccessEvent {
  SignUpRequestFailedEvent();
}

class CancelSignUpButtonClick extends AccessEvent {
  CancelSignUpButtonClick();
}
