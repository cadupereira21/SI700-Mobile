
abstract class UserRequesterState {}

class WaitingUserRequestState extends UserRequesterState {
  WaitingUserRequestState();
}

class ProcessingUserRequestState extends UserRequesterState {
  ProcessingUserRequestState();
}