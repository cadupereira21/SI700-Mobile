abstract class AuthMonitorState {
  String? message;
  AuthMonitorState({this.message});
}

class AuthenticatedState extends AuthMonitorState {
  AuthenticatedState({super.message});
}

class UnauthenticatedState extends AuthMonitorState  {
  UnauthenticatedState({super.message});
}

class AuthenticateRequestSuccessful extends AuthMonitorState {
  AuthenticateRequestSuccessful({super.message});
}

class AuthenticateRequestFailed extends AuthMonitorState {
  AuthenticateRequestFailed({super.message});
}
