import 'dart:convert';

import 'package:dio/dio.dart';

import '../Model/User.dart';

class UserServiceImp {
  final String _baseUrl = "https://seu-madeu-sucos-default-rtdb.firebaseio.com";
  final dio = Dio();

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();

  Future<bool> createUser(User user) async {
    final response = await dio.post("${_baseUrl}/users.json", data: json.encode({
      "email": user.email,
      "password": user.password,
      "Client":{
        "name": user.client!.name,
        "address": user.client!.address,
        "phone": user.client!.phone,
      },
      "activePlan": null
    }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao criar usuário!");
    }
  }
}
