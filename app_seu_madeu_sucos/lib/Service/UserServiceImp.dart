import 'dart:async';
import 'dart:convert';

import 'package:app_seu_madeu_sucos/Model/Address.dart';
import 'package:dio/dio.dart';
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

  Future<Response> getAllUsers() async {
    final response = await dio.get("$baseUrl/users.json");
    return response;
  }

  Future<void> getUserByEmail(String userEmail) async {
    var response = await getAllUsers();
    final userIds = (response.data as Map<String, dynamic>).keys;
    final userCollection = (response.data as Map<String, dynamic>).values;

    notify(
      requestTitle: UserServiceImp.REQ_TITLE_GET_USER,
      responseStatus: response.statusCode!.toInt() / 100 == 2
          ? RequestStatus.SUCCESSFUL
          : RequestStatus.FAILED,
      object: [_findUser(userIds, userCollection, userEmail)],
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
  
  UserModel _findUser(Iterable userIds, Iterable userCollection, String userEmail) {
    var index = 0;
    UserModel user = UserModel();
    userCollection.forEach((element){
      (element as Map<String, dynamic>).values.forEach((element) {
        if(userEmail == element['email'].toString()){
          Client client = Client();
          Address address = Address();

          address.setStreet = element['client']['address']['street'];
          address.setStreetNumber = element['client']['address']['streetNumber'];
          address.setNeighbour = element['client']['address']['neighbour'];
          address.setCity = element['client']['address']['city'];
          address.setDistrict = element['client']['address']['district'];
          address.setCep = element['client']['address']['zipcode'];

          client.setName = element['client']['name'].toString();
          client.setPhone = element['client']['phone'].toString();
          //client.setActivePlan = element['client']['activePlan']
          client.setAddress = address;

          user.setId = userIds.elementAt(index);
          user.setEmail = element['email'].toString();
          user.setClient = client;
        }
      });
      index++;
    });
    return user;
  }
}
