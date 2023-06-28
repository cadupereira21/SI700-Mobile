import 'dart:async';
import 'dart:convert';

import '../Model/Client.dart';
import '../Model/User.dart';
import 'RequestStatus.dart';
import 'Service.dart';

class UserServiceImp extends Service {
  static const String REQ_TITLE_CREATE_USER = "Create User Request";
  static const String REQ_TITLE_GET_USER = "Get User Request";
  static const String REQ_TITLE_UPDATE_USER = "Update User Request";
  static const String REQ_TITLE_DELETE_USER = "Update User Request";

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();

  Future<void> createUser(User user) async {
    final response = await dio.post("$baseUrl/users.json",
        data: json.encode({
          "email": user.email,
          "password": user.password,
          "client": {
            "name": user.client!.name,
            "address": {
              "street": user.client!.address!.street!,
              "streetNumber": user.client!.address!.streetNumber!,
              "neighbour" : user.client!.address!.neighbour!,
              "district" : user.client!.address!.district!,
              "city" : user.client!.address!.city,
              "zipcode" : user.client!.address!.cep,
            },
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
    final response = await dio.get("$baseUrl/users/$userId.json");
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

  Future<void> updateUser(String userId, User user) async {
    final response = await dio.put("$baseUrl/users/$userId.json",
        data: json.encode({
          "email": user.email,
          "password": user.password,
          "client": {
            "name": user.client!.name,
            "address": {
              "street": user.client!.address!.street!,
              "streetNumber": user.client!.address!.streetNumber!,
              "neighbour" : user.client!.address!.neighbour!,
              "district" : user.client!.address!.district!,
              "city" : user.client!.address!.city,
              "zipcode" : user.client!.address!.cep,
            },
            "phone": user.client!.phone,
          },
          "activePlan": user.client!.activePlan
        }));

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_UPDATE_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [user],
    );
  }

  Future<void> deleteUser(String userId) async {
    final response = await dio.delete("$baseUrl/users/$userId.json");

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_DELETE_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [],
    );
  }
}
