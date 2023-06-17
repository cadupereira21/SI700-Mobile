import '../../../Model/Client.dart';
import '../../../Model/User.dart';

abstract class UserMonitorEvent {}

class FetchUserDataEvent extends UserMonitorEvent {
  User user;
  FetchUserDataEvent({required this.user});
}

class LogInButtonClick extends UserMonitorEvent {
  LogInButtonClick();
}

class LogOutButtonClick extends UserMonitorEvent {
  LogOutButtonClick();
}

class IWantToSignUpButtonClick extends UserMonitorEvent {
  IWantToSignUpButtonClick();
}

class SignUpRequestSuccessfulEvent extends UserMonitorEvent {
  String? userId;
  User? user;
  SignUpRequestSuccessfulEvent({this.userId, this.user});
}

class SignUpRequestFailedEvent extends UserMonitorEvent {
  SignUpRequestFailedEvent();
}

class CancelSignUpButtonClick extends UserMonitorEvent {
  CancelSignUpButtonClick();
}
