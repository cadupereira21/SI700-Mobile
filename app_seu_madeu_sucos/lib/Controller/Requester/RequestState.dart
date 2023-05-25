abstract class RequestState{}

class ProcessingRequest extends RequestState{}

class RequestSuccess extends RequestState{
  String message;
  RequestSuccess({required this.message});
}

class RequestFailed extends RequestState{
  String message;
  RequestFailed({required this.message});
}