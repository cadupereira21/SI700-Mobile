import '../../../Model/UserModel.dart';

abstract class UserMonitorEvent {}

class FetchUserDataEvent extends UserMonitorEvent {
  UserModel user;
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
  UserModel? user;
  SignUpRequestSuccessfulEvent({this.userId, this.user});
}

class SignUpRequestFailedEvent extends UserMonitorEvent {
  SignUpRequestFailedEvent();
}

class CancelSignUpButtonClick extends UserMonitorEvent {
  CancelSignUpButtonClick();
}
