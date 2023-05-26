import 'dart:async';

import 'package:app_seu_madeu_sucos/Interface/Notifier.dart';
import 'package:dio/dio.dart';

import 'RequestStatus.dart';

abstract class Service implements Notifier{
  final String baseUrl = "https://seu-madeu-sucos-default-rtdb.firebaseio.com";
  final dio = Dio();

  StreamController? streamController;

  @override
  void notify(
      {String? requestTitle,
      RequestStatus? responseStatus,
      List<Object>? object}) {
    streamController?.sink.add([requestTitle, responseStatus, object]);
  }

  @override
  Stream get stream {
    streamController ??= StreamController.broadcast();
    return streamController!.stream;
  }
}