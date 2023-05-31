import '../RequestState.dart';

abstract class UserRequestState extends RequestState{}

class ProcessingUserRequest extends UserRequestState{}

class UserRequestSuccess extends UserRequestState{
  String message;
  UserRequestSuccess({required this.message});
}

class UserRequestFailed extends UserRequestState{
  String message;
  UserRequestFailed({required this.message});
}