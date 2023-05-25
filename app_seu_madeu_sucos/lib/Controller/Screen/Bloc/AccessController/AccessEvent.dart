abstract class AccessEvent {}

class LogInButtonClick extends AccessEvent {
  LogInButtonClick();
}

class IWantToSignUpButtonClick extends AccessEvent {
  IWantToSignUpButtonClick();
}

class SignUpRequestSuccessfulEvent extends AccessEvent {
  SignUpRequestSuccessfulEvent();
}

class CancelSignUpButtonClick extends AccessEvent {
  CancelSignUpButtonClick();
}


