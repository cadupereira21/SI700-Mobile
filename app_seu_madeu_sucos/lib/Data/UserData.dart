import '../Model/Client.dart';

class UserData {
  String? _id;
  String? _email;
  String? _password;

  static UserData instance = UserData._createInstance();

  UserData._createInstance();

  void setId(String? id) {
    _id = id;
  }

  void setEmail(String? email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? get id => _id;
  String? get username => _email;
}
