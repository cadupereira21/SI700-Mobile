import '../Model/Client.dart';

class UserData {
  String? _email;
  String? _password;

  static UserData instance = UserData._createInstance();

  UserData._createInstance();

  void setEmail(String? email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? get username => _email;
  String? get password => _password;
}
