import 'dart:async';
import 'dart:convert';

import 'package:app_seu_madeu_sucos/Controller/Requester/RequestState.dart';
import 'package:dio/dio.dart';

import '../Interface/Notifier.dart';
import '../Model/User.dart';
import 'RequestStatus.dart';

class UserServiceImp implements Notifier {
  final String _REQ_TITLE_CREATE_USER = "Create User Request";

  final String _baseUrl = "https://seu-madeu-sucos-default-rtdb.firebaseio.com";
  final _dio = Dio();

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();
  StreamController? _streamController;

  Future<void> createUser(User user) async {
    final response = await _dio.post("${_baseUrl}/users.json",
        data: json.encode({
          "email": user.email,
          "password": user.password,
          "client": {
            "name": user.client!.name,
            "address": user.client!.address,
            "phone": user.client!.phone,
          },
          "activePlan": null
        })); 
    notify(requestTitle: _REQ_TITLE_CREATE_USER, responseStatus: RequestStatus.SUCCESSFUL);
  }

  @override
  void notify(
      {String? requestTitle, RequestStatus? responseStatus, List<Object>? object}) {
    _streamController?.sink.add([requestTitle, responseStatus, object]);
  }

  @override
  // TODO: implement stream
  Stream get stream {
    _streamController ??= StreamController.broadcast();
    return _streamController!.stream;
  }
}
