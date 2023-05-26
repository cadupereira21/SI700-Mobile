import 'dart:async';
import 'dart:convert';

import 'package:app_seu_madeu_sucos/Controller/Requester/RequestState.dart';
import 'package:dio/dio.dart';

import '../Interface/Notifier.dart';
import '../Model/Client.dart';
import '../Model/User.dart';
import 'RequestStatus.dart';

class UserServiceImp implements Notifier {
  static const String REQ_TITLE_CREATE_USER = "Create User Request";
  static const String REQ_TITLE_GET_USER = "Get User Request";

  final String _baseUrl = "https://seu-madeu-sucos-default-rtdb.firebaseio.com";
  final _dio = Dio();

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();
  StreamController? _streamController;

  Future<void> createUser(User user) async {
    final response = await _dio.post("$_baseUrl/users.json",
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

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_CREATE_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [response.data['name'].toString(), user],
    );
  }

  Future<void> getUserById(String? userId) async {
    User user = User();
    Client client = Client();
    final response = await _dio.get("$_baseUrl/users/$userId.json");
    //{client: {address: f, f, f, f-f, f, name: f, phone: f}, email: f, password: f}

    client.address = response.data['client']['address'];
    client.name = response.data['client']['name'];
    client.phone = response.data['client']['phone'];
    user.client = client;
    user.email = response.data['email'];

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_GET_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [user],
    );
  }

  @override
  void notify(
      {String? requestTitle,
      RequestStatus? responseStatus,
      List<Object>? object}) {
    _streamController?.sink.add([requestTitle, responseStatus, object]);
  }

  @override
  // TODO: implement stream
  Stream get stream {
    _streamController ??= StreamController.broadcast();
    return _streamController!.stream;
  }
}
