abstract class OrderRequesterState {}

class WaitingOrderRequestState extends OrderRequesterState {
  WaitingOrderRequestState();
}

class ProcessingOrderRequestState extends OrderRequesterState {
  ProcessingOrderRequestState();
}
