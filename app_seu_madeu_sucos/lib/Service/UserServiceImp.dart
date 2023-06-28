import 'dart:async';
import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../Model/Client.dart';
import '../Model/UserModel.dart';
import 'RequestStatus.dart';
import 'Service.dart';

class UserServiceImp extends Service {
  static const String REQ_TITLE_CREATE_USER = "Create User Request";
  static const String REQ_TITLE_GET_USER = "Get User Request";
  static const String REQ_TITLE_UPDATE_USER = "Update User Request";
  static const String REQ_TITLE_DELETE_USER = "Update User Request";

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();

  Future<void> createUser(UserModel user) async {
    final userId = const Uuid().v1();

    final response = await dio.post(
      "$baseUrl/users/$userId.json",
      data: user.toMap(),
    );
    

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_CREATE_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [userId.toString(), user],
    );
  }

  Future<void> getUserById(String? userId) async {
    UserModel user = UserModel();
    Client client = Client();
    final response = await dio.get("$baseUrl/users/$userId.json");
    //{client: {address: f, f, f, f-f, f, name: f, phone: f}, email: f, password: f}

    client.setAddress = response.data['client']['address'];
    client.setName = response.data['client']['name'];
    client.setPhone = response.data['client']['phone'];
    user.setClient = client;
    user.setEmail = response.data['email'];

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_GET_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [user],
    );
  }

  Future<void> updateUser(String userId, UserModel user) async {
    final response = await dio.put("$baseUrl/users/$userId.json",
        data: json.encode({
          "email": user.getEmail,
          "password": user.getPassword,
          "client": {
            "name": user.getClient.getName,
            "address": {
              "street": user.getClient.getAddress.getStreet,
              "streetNumber": user.getClient.getAddress.getStreetNumber,
              "neighbour" : user.getClient.getAddress.getNeighbour,
              "district" : user.getClient.getAddress.getDistrict,
              "city" : user.getClient.getAddress.getCity,
              "zipcode" : user.getClient.getAddress.getCep,
            },
            "phone": user.getClient.getPhone,
          },
          "activePlan": user.getClient.getActivePlan
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
