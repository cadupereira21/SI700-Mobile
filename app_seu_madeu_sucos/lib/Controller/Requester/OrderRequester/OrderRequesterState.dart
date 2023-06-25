abstract class OrderRequesterState {}

class WaitingOrderRequestState extends OrderRequesterState {
  WaitingOrderRequestState();
}

class ProcessingOrderRequestState extends OrderRequesterState {
  ProcessingOrderRequestState();
}

class SuccessfulOrderRequestState extends OrderRequesterState {
  String? message;
  SuccessfulOrderRequestState({this.message});
}

class FailedOrderRequestState extends OrderRequesterState {
  String? message;
  FailedOrderRequestState({this.message});
}
