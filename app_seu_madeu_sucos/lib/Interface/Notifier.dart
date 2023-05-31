import '../Service/RequestStatus.dart';

abstract class Notifier {
  Stream get stream;
  void notify({String? requestTitle, RequestStatus? responseStatus, List<Object>? object});
}
