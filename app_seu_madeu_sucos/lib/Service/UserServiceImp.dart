import 'package:dio/dio.dart';

import '../Model/User.dart';

class UserServiceImp {
  final String baseUrl = "https://seu-madeu-sucos-default-rtdb.firebaseio.com/";
  final dio = Dio();

  static final UserServiceImp instance = UserServiceImp._internal();
  UserServiceImp._internal();

  Future<bool> createUser(User user) async {
    final response = await dio.post(baseUrl + "users.json", data: user);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao criar usuário!");
    }
  }
}
